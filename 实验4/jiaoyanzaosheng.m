% 添加椒盐噪声函数
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

% 添加椒盐噪声(噪声密度5%)
noisy_img = add_salt_pepper(original_img, 0.05);

% 显示噪声图像
figure;
imshow(noisy_img);
title('添加椒盐噪声后的图像(密度5%)');