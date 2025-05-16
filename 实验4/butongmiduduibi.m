function noisy_img = add_salt_pepper(img, noise_density)
    % img: 输入图像
    % noise_density: 噪声密度(0-1)
    
    [M, N] = size(img);
    noisy_img = img;
    
    % 计算噪声像素数量
    num_noise = round(noise_density * M * N);
    
    % 添加盐噪声(白色)
    salt_indices = randperm(M*N, num_noise);
    noisy_img(salt_indices) = 255;
    
    % 添加胡椒噪声(黑色)
    pepper_indices = randperm(M*N, num_noise);
    noisy_img(pepper_indices) = 0;
end
% 测试不同噪声密度下的滤波效果
noise_levels = [0.01, 0.05, 0.1, 0.2]; % 1%, 5%, 10%, 20%
results = cell(length(noise_levels), 4);

figure('Position', [100, 100, 1400, 800]);

for i = 1:length(noise_levels)
    % 添加噪声
    noisy = add_salt_pepper(original_img, noise_levels(i));
    
    % 应用各种滤波
    mean_filt = imfilter(noisy, fspecial('average', [5 5]), 'replicate');
    median_filt = medfilt2(noisy, [5 5]);
    gaussian_filt = imfilter(noisy, fspecial('gaussian', [5 5], 1), 'replicate');
    
    % 存储结果
    results{i,1} = noisy;
    results{i,2} = mean_filt;
    results{i,3} = median_filt;
    results{i,4} = gaussian_filt;
    
    % 显示结果
    subplot(length(noise_levels), 4, (i-1)*4+1);
    imshow(noisy);
    title(sprintf('噪声密度 %.0f%%', noise_levels(i)*100));
    
    subplot(length(noise_levels), 4, (i-1)*4+2);
    imshow(mean_filt);
    title('均值滤波');
    
    subplot(length(noise_levels), 4, (i-1)*4+3);
    imshow(median_filt);
    title('中值滤波');
    
    subplot(length(noise_levels), 4, (i-1)*4+4);
    imshow(gaussian_filt);
    title('高斯滤波');
end