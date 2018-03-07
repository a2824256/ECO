function [ feature_map ] = get_fcn_layers(im, fparams, gparams)
% Get layers from a fcn.
net = dagnn.DagNN.loadobj(load('networks/pascal-fcn8s-dag.mat'));
net.mode = 'test';
im_= single(im);
im_= imresize(im_,net.meta.normalization.imageSize(1:2));
im_= bsxfun(@minus,im_ ,net.meta.normalization.averageImage);
net.eval({'data',im_});
%�������
feature_map{1} = net.vars(net.getVarIndex('upscore')).value;
%���ԣ�ȡ��ǰ����ͨ��
feature_map{1} = feature_map{1}(:,:,1:2);