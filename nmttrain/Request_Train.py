import jieba
import os
import argparse
import sys
import requests
import json
import pickle

train_token_chinese = []
train_token_english = []

def segment(corpusName):
    print (">>>>>>>>>>分词<<<<<<<<<<")
    trainTarget = "L:\\nmttrain\\corpus" + "\\" + corpusName + ".txt"
    train_chinese = []
    train_english = []
    with open(trainTarget, encoding='utf-8') as fhdl:
        flag = 0
        for line in fhdl:
            if flag == 0:
                train_english.append(line.strip())
            else:
                train_chinese.append(line.strip())
            flag = flag ^ 1
    print ("共有英文句子：", len(train_english))
    print ("共有中文句子：", len(train_chinese))

    for ch, en in zip(train_chinese, train_english):
        token_ch = [i for i in ch if i.strip()]
        token_en = [i.lower() for i in jieba.cut(en) if i.strip()]
        train_token_chinese.append(token_ch)
        train_token_english.append(token_en)
    print (">>>>>>>>>>分词完毕<<<<<<<<<<")


def word2index(max_words, model):
    max_words = int(max_words)
    print (">>>>>>>>>>序列化<<<<<<<<<<")
    print ("加载词典")
    if model == "Ch2En":
        with open('L:/nmttrain/Ch2En_dic.pkl', 'rb') as fhdl:
            (
                ind2ch,
                ch2ind,
                ind2en,
                en2ind,
            ) = pickle.load(fhdl)
        print ("加载词典完毕")

        train_x = [[ch2ind.get(j, 0) for j in i] for i in train_token_chinese if
                   (max_words == -1 or len(i) < max_words)]
        train_y = [[en2ind.get(j, 0) for j in i] for i in train_token_english if
                   (max_words == -1 or len(i) < max_words)]
        with open("L:/nmttrain/middleresult/DataForTraining.pkl", "wb") as whdl:
            pickle.dump((
                train_x,        # 中
                train_y,        # 英
            ),whdl)
        print (">>>>>>>>>>序列化完毕<<<<<<<<<<")
    else:
        with open('L:/nmttrain/dic.pkl', 'rb') as fhdl:
            (
                ind2ch,
                ch2ind,
                ind2en,
                en2ind,
            ) = pickle.load(fhdl)
        print ("加载词典完毕")
        train_x = [[en2ind.get(j, 0) for j in i] for i in train_token_english if
                   (max_words == -1 or len(i) < max_words)]
        train_y = [[ch2ind.get(j, 0) for j in i] for i in train_token_chinese if
                   (max_words == -1 or len(i) < max_words)]
        with open("L:/nmttrain/middleresult/DataForTraining.pkl", "wb") as whdl:
            pickle.dump((
                train_x,        # 英
                train_y,        # 中
            ),whdl)
        print (">>>>>>>>>>序列化完毕<<<<<<<<<<")


def train(model, batch_size, n_epoch, lr, max_grad):
    batch_size = int(batch_size)
    n_epoch = int(n_epoch)
    lr = int(lr)
    max_grad = int(max_grad)
    trainPara = {'model':model, 'batch_size':batch_size, 'n_epoch':n_epoch, 'lr':lr, 'max_grad':max_grad}
    r = requests.get("http://localhost:8844/TrainModel/train", data=trainPara)
    print ('>>>>>>>>>>训练完成<<<<<<<<<<')







if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('model',type=str,help='model')
    parser.add_argument('corpusName',type=str,help='Corpus Name')
    parser.add_argument('batch_size', type=str, help='batch_size')
    parser.add_argument('n_epoch', type=str, help='n_epoch')
    parser.add_argument('lr', type=str, help='lr')
    parser.add_argument('max_grad', type=str, help='max_grad')
    args = parser.parse_args(sys.argv[1:])
    segment(args.corpusName)
    word2index(-1, args.model)
    print ('请求训练微服务')
    train(args.model, args.batch_size, args.n_epoch, args.lr, args.max_grad)