import flask
from flask import Flask
from flask import request
from flask import jsonify
import pickle
import tensorflow as tf
import argparse
from sklearn.model_selection import train_test_split
from tensorflow.python.layers import core as layers_core
from utils import *
import nltk
import numpy as np


app = Flask(__name__)

def cal_acc(logits, target, seq_max_len):
    max_seq = max(target.shape[1], logits.shape[1])
    if max_seq - target.shape[1]:
        target = np.pad(
            target,
            [(0, 0), (0, max_seq - target.shape[1])],
            'constant'
        )
    if max_seq - logits.shape[1]:
        logits = np.pad(
            logits,
            [(0, 0), (0, max_seq - logits.shape[1])],
            'constant'
        )
    return np.mean(np.equal(target[:, :seq_max_len], logits[:, :seq_max_len]))

def get_bleu_score(predict, target):
    try:
        target = [[[j for index, j in enumerate(i) if j > 0 or index < 4]] for i in target]
        predict = [[j for index, j in enumerate(i) if j > 0 or index < 4] for i in predict]
        BLEUscore = nltk.translate.bleu_score.corpus_bleu(target, predict)
    except:
        BLEUscore = -1
    return BLEUscore

def get_all_en_text(x, ind2en):
    return [' '.join([ind2en.get(j, '') for j in i]) for i in x]

def get_all_ch_text(x, ind2ch):
    return [' '.join([ind2ch.get(j, '') for j in i]) for i in x]


@app.route('/TrainModel/train', methods=['GET', 'POST'])
def train_model():
    with open('L:/nmttrain/middleresult/DataForTraining.pkl', 'rb') as fhdl:
        (
            train_x,
            train_y
        ) = pickle.load(fhdl)
    model = request.form['model']
    batch_size = request.form['batch_size']
    batch_size = int(batch_size)
    n_epoch = request.form['n_epoch']
    n_epoch = int(n_epoch)
    lr = request.form['lr']
    lr = int(lr)
    max_grad = request.form['max_grad']
    max_grad = int(max_grad)
    seq_max_len = 40
    dropout = 0.2
    layer_number = 2
    if (model == 'Ch2En'):
        src_vocab_size = 9892
        target_vocat_size = 60003
        attention_hidden_size = 256
        attention_output_size = 256
        embedding_size = 256
        num_units = 256
        with open('L:/nmttrain/Ch2En_dic.pkl', 'rb') as fhdl:
            (
                ind2ch,
                ch2ind,
                ind2en,
                en2ind,
            ) = pickle.load(fhdl)
    else:
        src_vocab_size = 50003
        target_vocat_size = 8826
        attention_hidden_size = 512
        attention_output_size = 512
        embedding_size = 512
        num_units = 512
        with open('L:/nmttrain/dic.pkl', 'rb') as fhdl:
            (
                ind2ch,
                ch2ind,
                ind2en,
                en2ind,
            ) = pickle.load(fhdl)

    train_x = tf.contrib.keras.preprocessing.sequence.pad_sequences(
        train_x, seq_max_len, padding='post'
    )
    train_y = tf.contrib.keras.preprocessing.sequence.pad_sequences(
        train_y, seq_max_len, padding='post'
    )

    train_x, test_x, train_y, test_y = train_test_split(
        train_x, train_y,
        test_size=0.01,
        random_state=42
    )
    train_x[train_x >= src_vocab_size] = 1
    test_x[test_x >= src_vocab_size] = 1
    train_y[train_y >= target_vocat_size] = 1
    test_y[test_y >= target_vocat_size] = 1

    tf.reset_default_graph()
    config = tf.ConfigProto(log_device_placement=True, allow_soft_placement=True)
    config.gpu_options.allow_growth = True
    session = tf.Session(config=config)

    with tf.device('/gpu:1'):

        x = tf.placeholder('int32', [None, None])
        y = tf.placeholder('int32', [None, None])
        y_in = tf.placeholder('int32', [None, None])
        x_len = tf.placeholder('int32', [None])
        y_len = tf.placeholder('int32', [None])
        x_real_len = tf.placeholder('int32', [None])
        y_real_len = tf.placeholder('int32', [None])
        learning_rate = tf.placeholder(tf.float32, shape=[])

        embedding_encoder = tf.get_variable(
            'embedding_encoder',
            [src_vocab_size, embedding_size],
            dtype=tf.float32
        )
        embedding_decoder = tf.get_variable(
            'embedding_decoder',
            [target_vocat_size, embedding_size],
            dtype=tf.float32
        )
        # encoder_emb_inp与decoder_emb_inp 的形式都为 [batch_size, max_time, embedding_size]
        encoder_emb_inp = tf.nn.embedding_lookup(embedding_encoder, x)
        decoder_emb_inp = tf.nn.embedding_lookup(embedding_decoder, y_in)

        # encoder
        num_bi_layers = int(layer_number / 2)  # 双向循环神经网络，两个方向各自的层数
        # forward RNN(LSTM)
        cell_list = []
        for i in range(num_bi_layers):
            cell_list.append(
                tf.contrib.rnn.DropoutWrapper(
                    tf.contrib.rnn.BasicLSTMCell(num_units),
                    input_keep_prob=(1.0 - dropout)
                )
            )
        if len(cell_list) == 1:
            encoder_cell = cell_list[0]
        else:
            encoder_cell = tf.contrib.rnn.MultiRNNCell(cell_list)

        # backward RNN(LSTM)
        cell_list = []
        for i in range(num_bi_layers):
            cell_list.append(
                tf.contrib.rnn.DropoutWrapper(
                    tf.contrib.rnn.BasicLSTMCell(num_units),
                    input_keep_prob=(1.0 - dropout)
                )
            )
        if len(cell_list) == 1:
            encoder_backword_cell = cell_list[0]
        else:
            encoder_backword_cell = tf.contrib.rnn.MultiRNNCell(cell_list)

        # 将 前向循环神经网络 与 反向循环神经网络 组合成 双向循环神经网络
        bi_outputs, bi_encoder_state = tf.nn.bidirectional_dynamic_rnn(
            encoder_cell, encoder_backword_cell, encoder_emb_inp,
            sequence_length=x_len, dtype=tf.float32
        )
        encoder_outputs = tf.concat(bi_outputs, -1)

        if num_bi_layers == 1:
            encoder_state = bi_encoder_state
        else:
            encoder_state = []
            for layer_id in range(num_bi_layers):
                encoder_state.append(bi_encoder_state[0][layer_id])  # forward
                encoder_state.append(bi_encoder_state[1][layer_id])  # backward
            encoder_state = tuple(encoder_state)

        # decoder
        cell_list = []
        for i in range(layer_number):
            cell_list.append(
                tf.contrib.rnn.DropoutWrapper(
                    tf.contrib.rnn.BasicLSTMCell(num_units), input_keep_prob=(1.0 - dropout)
                )
            )
        if len(cell_list) == 1:
            decoder_cell = cell_list[0]
        else:
            decoder_cell = tf.contrib.rnn.MultiRNNCell(cell_list)

        # attention
        attention_mechanism = tf.contrib.seq2seq.LuongAttention(
            attention_hidden_size, encoder_outputs,
            memory_sequence_length=x_real_len, scale=True
        )
        decoder_cell = tf.contrib.seq2seq.AttentionWrapper(
            decoder_cell, attention_mechanism,
            attention_layer_size=attention_output_size
        )

        projection_layer = layers_core.Dense(
            target_vocat_size, use_bias=False
        )

        # Dynamic decoding
        with tf.variable_scope("decode_layer"):
            helper = tf.contrib.seq2seq.TrainingHelper(
                decoder_emb_inp, sequence_length=y_len
            )
            decoder = tf.contrib.seq2seq.BasicDecoder(
                decoder_cell, helper, initial_state=decoder_cell.zero_state(dtype=tf.float32, batch_size=batch_size),
                output_layer=projection_layer
            )

            outputs, _, ___ = tf.contrib.seq2seq.dynamic_decode(decoder)
            logits = outputs.rnn_output

            target_weights = tf.sequence_mask(
                y_real_len, seq_max_len, dtype=logits.dtype
            )

        # predicting
        # Helper
        with tf.variable_scope("decode_layer", reuse=True):
            if model == 'Ch2En':
                helper_predict = tf.contrib.seq2seq.GreedyEmbeddingHelper(
                    embedding_decoder,
                    tf.fill([batch_size], en2ind['<go>']),
                    0
                )
            else:
                helper_predict = tf.contrib.seq2seq.GreedyEmbeddingHelper(
                    embedding_decoder,
                    tf.fill([batch_size], ch2ind['<go>']),
                    0
                )
            decoder_predict = tf.contrib.seq2seq.BasicDecoder(
                decoder_cell, helper_predict,
                initial_state=decoder_cell.zero_state(dtype=tf.float32, batch_size=batch_size),
                output_layer=projection_layer
            )
            outputs_predict, _, __ = tf.contrib.seq2seq.dynamic_decode(
                decoder_predict, maximum_iterations=test_y.shape[1] * 2
            )
        translations = outputs_predict.sample_id

        # calculate loss
        crossent = tf.nn.sparse_softmax_cross_entropy_with_logits(
            labels=y, logits=logits
        )
        train_loss = (tf.reduce_sum(crossent * target_weights) / batch_size)
        optimizer_ori = tf.train.GradientDescentOptimizer(learning_rate=learning_rate)
        trainable_params = tf.trainable_variables()
        gradients = tf.gradients(train_loss, trainable_params)
        clip_gradients, _ = tf.clip_by_global_norm(gradients, max_grad)
        global_step = tf.Variable(0, trainable=False, name='global_step')
        optimizer = optimizer_ori.apply_gradients(
            zip(clip_gradients, trainable_params), global_step=global_step
        )

        # 加载模型
        saver = tf.train.Saver()
        if model == 'Ch2En':
            saver.restore(session, 'L:/nmtcore/Ch2En/result_Ch2En')
        else:
            saver.restore(session, "L:/nmtcore/En2Ch/result_En2Ch")

        train_set = Dataset(train_x, train_y)
        test_set = Dataset(test_x, test_y)

        def calc_test_loss(test_set, batch_size, test_x, seq_max_len, session, train_loss, translations, lan2ind,
                           display=True):
            accs = []
            worksum = int(len(test_x) / batch_size)
            loss_list = []
            predict_list = []
            target_list = []
            source_list = []
            pb = ProgressBar(worksum=worksum, info="validating...", auto_display=display)
            pb.startjob()
            for j in range(worksum):
                batch_x, batch_y = test_set.next_batch(batch_size)
                lx = [seq_max_len] * batch_size
                ly = [seq_max_len] * batch_size
                bx = [np.sum(m > 0) for m in batch_x]
                by = [np.sum(m > 0) for m in batch_y]
                tmp_loss, tran = session.run([train_loss, translations],
                                             feed_dict={
                                                 x: batch_x, y: batch_y,
                                                 y_in: np.concatenate(
                                                     (np.ones((batch_y.shape[0], 1), dtype=np.int) * lan2ind['<go>'],
                                                      batch_y[:, :-1]), axis=1
                                                 ),
                                                 x_len: lx, y_len: ly,
                                                 y_real_len: by, x_real_len: bx})
                loss_list.append(tmp_loss)
                tmp_acc = cal_acc(tran, batch_y, seq_max_len)
                accs.append(tmp_acc)
                predict_list += [i for i in tran]
                target_list += [i for i in batch_y]
                source_list += [i for i in batch_x]
                pb.complete(1)
            return np.average(loss_list), np.average(accs), get_bleu_score(predict_list,
                                                                           target_list), predict_list, target_list, source_list

        # Train
        i_save = 0
        j_save = 0
        restore = True
        for i in range(i_save, n_epoch):
            i_save = i
            worksum = int(len(train_y) / batch_size)
            pb = ProgressBar(worksum=worksum)
            pb.startjob()
            train_loss_list = []
            train_acc_list = []
            for j in range(worksum):
                if restore == True and j < j_save:
                    pb.finishsum += 1
                    continue
                restore = False

                j_save = j
                batch_x, batch_y = train_set.next_batch(batch_size)
                lx = [seq_max_len] * batch_size
                ly = [seq_max_len] * batch_size
                bx = [np.sum(m > 0) for m in batch_x]
                by = [np.sum(m > 0) for m in batch_y]
                by = [m + 2 if m < seq_max_len - 1 else m for m in by]
                if model == 'Ch2En':
                    _, loss = session.run([optimizer, train_loss],
                                          feed_dict={
                                              x: batch_x, y: batch_y,
                                              x_len: lx, y_len: ly,
                                              learning_rate: lr,
                                              y_in: np.concatenate(
                                                  (np.ones((batch_y.shape[0], 1), dtype=np.int) * en2ind['<go>'],
                                                   batch_y[:, :-1]), axis=1
                                              ),
                                              y_real_len: by, x_real_len: bx
                                          })
                else:
                    _, loss = session.run([optimizer, train_loss],
                                          feed_dict={
                                              x: batch_x, y: batch_y,
                                              x_len: lx, y_len: ly,
                                              learning_rate: lr,
                                              y_in: np.concatenate(
                                                  (np.ones((batch_y.shape[0], 1), dtype=np.int) * ch2ind['<go>'],
                                                   batch_y[:, :-1]), axis=1
                                              ),
                                              y_real_len: by, x_real_len: bx
                                          })
                train_loss_list.append(loss)
                pb.info = "iter {} loss:{} lr:{}".format(i + 1, loss, lr)
                val_step = int(worksum / 4)
                if j % val_step == 0 and j != 0:
                    if model == 'Ch2En':
                        test_loss, test_acc, bleu_score, predict_list, target_list, source_list = calc_test_loss(
                            test_set, batch_size, test_x, seq_max_len, session, train_loss, translations, en2ind)
                        _, train_acc, train_bleu_score, train_predict_list, train_target_list, train_source_list = calc_test_loss(
                            Dataset(train_x[::100], train_y[::100]), batch_size, test_x, seq_max_len, session,
                            train_loss, translations, en2ind,
                            display=False)
                    else:
                        test_loss, test_acc, bleu_score, predict_list, target_list, source_list = calc_test_loss(
                            test_set, batch_size, test_x, seq_max_len, session, train_loss, translations, ch2ind)
                        _, train_acc, train_bleu_score, train_predict_list, train_target_list, train_source_list = calc_test_loss(
                            Dataset(train_x[::100], train_y[::100]), batch_size, test_x, seq_max_len, session,
                            train_loss, translations, ch2ind,
                            display=False)
                    print(
                        "\niter {} step {} train loss {} train acc {} test loss {} test acc {} bleu {} lr {}\n".format(
                            i + 1, j,
                            np.average(
                                train_loss_list[
                                -val_step:]
                            ),
                            train_acc,
                            test_loss,
                            test_acc,
                            bleu_score,
                            lr))
                    try:
                        saver = tf.train.Saver()
                        if model == 'Ch2En':
                            saver.save(session, 'L:/nmtcore/Ch2En/result_Ch2En')
                        else:
                            saver.save(session, 'L:/nmtcore/En2Ch/result_En2Ch')
                        # saver.save(session, 'middleresult/{}/result_{}_{}'.format(model_path, i + 1, j))
                    except:
                        print('save fail')
                lr_step = int(worksum / 2) - 1
                if j % lr_step == 0 and j != 0:
                    if (i + 1) > 10:
                        lr = lr / 2
                pb.complete(1)
    return jsonify(errcode='success')

if __name__ == '__main__':
    app.run(port=8844, threaded=True)