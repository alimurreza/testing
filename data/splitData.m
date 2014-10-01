
%% depth data. Already separated


%%
data_type = 5;
set_type = 2;
data_type_string = {'rgb_image', 'super_pixels', 'point_cloud', 'ground_truth'};
set_type_string = {'train', 'test'};
img_path =  ['/home/reza/work/ambiguity_project/data/depth/' set_type_string{set_type} '/'];
dest_path = ['/home/reza/work/ambiguity_project/data/' data_type_string{data_type} '/' set_type_string{set_type} '/'];
src_path =  ['/home/reza/work/ambiguity_project/data/' data_type_string{data_type} '/'];
imgList = dir([img_path '*.mat']);

for ii=1:length(imgList)
    if (data_type == 1) % rgb
        copyfile([src_path imgList(ii).name(1:end-4) '.png'], [dest_path imgList(ii).name(1:end-4) '.png']);
    elseif (data_type == 2) % super_pixel
        copyfile([src_path imgList(ii).name(1:end-4) '.mat'], [dest_path imgList(ii).name(1:end-4) '.mat']);
    elseif (data_type == 3) % point cloud
        copyfile([src_path imgList(ii).name(1:end-4) '.mat'], [dest_path imgList(ii).name(1:end-4) '.mat']);
    elseif (data_type == 4) % ground truth
        copyfile([src_path imgList(ii).name(1:end-4) '_gt.png'], [dest_path imgList(ii).name(1:end-4) '_gt.png']);        
    end
end

keyboard;
