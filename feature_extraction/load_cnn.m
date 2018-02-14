function net = load_cnn(fparams, im_size)

net = load(['networks/' fparams.nn_name]);

% 修复当前神经网络
net = vl_simplenn_tidy(net);
% 遍历1到output_layer最大值
net.layers = net.layers(1:max(fparams.output_layer));

if strcmpi(fparams.input_size_mode, 'cnn_default')
    base_input_sz = net.meta.normalization.imageSize(1:2);
elseif strcmpi(fparams.input_size_mode, 'adaptive')
    base_input_sz = im_size(1:2);
else
    error('Unknown input_size_mode');
end

net.meta.normalization.imageSize(1:2) = round(base_input_sz .* fparams.input_size_scale);
net.meta.normalization.averageImageOrig = net.meta.normalization.averageImage;

if isfield(net.meta,'inputSize')
    net.meta.inputSize = base_input_sz;
end

if size(net.meta.normalization.averageImage,1) > 1 || size(net.meta.normalization.averageImage,2) > 1
    net.meta.normalization.averageImage = imresize(single(net.meta.normalization.averageImage), net.meta.normalization.imageSize(1:2));
end
%显示网络结构
net.info = vl_simplenn_display(net);
end