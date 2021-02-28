# NeuralMachineTranslation

# 项目介绍
本项目开发了一个集机器翻译与人工翻译于一体的翻译网站，以机器翻译为主要实现方向，通过整合人工翻译的结果形成训练 语料，使用在线模型训练功能结合训练语料对后台的机器翻译模型不断进行训练优化，该网站共包含三个部分：机器翻译子系 统、人工翻译交流平台子系统、管理员网站管理子系统。该网站的开发基于Java Web开发技术、REST API设计理论以及Flask 框架实现整体架构，以seq2seq模型作为理论基础并使用TensorFlow框架搭建基于LSTM的Encoder-Decoder + Attention 架构的神经网络模型，前端使用layui前端框架，后台所采用的数据库是MySQL。

# 网站功能结构图
![image](https://github.com/coderZMR/NMT/blob/main/Resources4ReadMe/%E7%BD%91%E7%AB%99%E5%8A%9F%E8%83%BD%E7%BB%93%E6%9E%84%E5%9B%BE.png)

# 网站实体属性图
![image](https://github.com/coderZMR/NMT/blob/main/Resources4ReadMe/%E7%BD%91%E7%AB%99%E5%AE%9E%E4%BD%93%E5%B1%9E%E6%80%A7%E5%9B%BE.png)

# 测试环境
* 硬件：CPU：intel core i7-6700HQ CPU @ 2.60GHz(8 CPUs), ~2.6GHz，内存：16GB，GPU GeForce GTX 960M，显存 4G。  
* 操作系统：Windows 10。

#### 注：因GitHub空间限制，当前仅上传了源代码，其他内容（训练好后的模型、数据集等）没有上传。
