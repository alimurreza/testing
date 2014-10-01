
%% we use previously saved depth map and crop it according to the size suggestedby the author
src_path = '/home/reza/Data/nyu_version_d2/nyud_v2/train/';
depth_path = '/home/reza/work/ambiguity_project/data/depth/train/';
depthList = dir([src_path '*.mat']);

for ii=1:length(depthList)
    load([src_path depthList(ii).name]);
    depth = depth(46:470,41:600); % truncate the depth as the Author says in his website (Perceptual Organization paper)
    % modified name
    modified_name = [depth_path depthList(ii).name];
    save(modified_name, 'depth');
 
end

keyboard;


%% to get the pc for each image. Since they already provided the pc. I just used it.
src_path = '/home/reza/work/rgbd-dev/data/pointCloud/';
pc_path = '/home/reza/work/ambiguity_project/data/point_cloud/';
pcList = dir([src_path '*.mat']);

for ii=1:length(pcList)
    load([src_path pcList(ii).name]); % load x3, y3, and z3
    [r c] = size(x3);
    pc = zeros(r,c,3);
    pc(:,:,1) = x3; pc(:,:,2) = y3; pc(:,:,3) = z3;
    % modified name
    im_no = str2num(pcList(ii).name(end-7:end-4))-5000;
    modified_name = [pc_path 'nyud_v2_' num2str(im_no) '.mat'];
    save(modified_name, 'pc');
 
end

keyboard;

%% to do get the ground truth image
benchmark_path = '/home/reza/work/rgbd-dev/data/benchmarkData/groundTruth/';
segList = dir([benchmark_path '*.mat']);

gt_path = '/home/reza/work/ambiguity_project/data/ground_truth/';

for ii=1:length(segList)
    dt = load([benchmark_path segList(ii).name]);
    gtClass = dt.groundTruth{1}.SegmentationClass;

    % modified name
    im_no = str2num(segList(ii).name(end-7:end-4))-5000;
    modified_name = [gt_path 'nyud_v2_' num2str(im_no) '_gt.png'];
    imwrite(gtClass, modified_name);
    
end


keyboard;
%% rename the rgb image

src_path = '/home/reza/work/rgbd-dev/data/colorImage/';
rgb_path = '/home/reza/work/ambiguity_project/data/rgb_image/';
imgList = dir([src_path '*.png']);

for ii=1:length(imgList)
    im = imread([src_path imgList(ii).name]);
    
    % modified name
    im_no = str2num(imgList(ii).name(end-7:end-4))-5000;
    modified_name = [rgb_path 'nyud_v2_' num2str(im_no) '.png'];
    imwrite(im, modified_name);
    
end

keyboard;

%% get the segments from Perceptual organization
path = getPaths(0);
segment_path = '/home/reza/work/rgbd-dev/cachedir/release/output/ucm/';
segList = dir([segment_path '*.mat']);

superpixels_path = '/home/reza/work/rgbd-dev/cachedir/release/output/super_pixels/';

for ii=1:length(segList)
    load([segment_path segList(ii).name])
    allResultsFileName = fullfile(path.outDir, 'allBUSResults.mat');
    dt = load(allResultsFileName, 'th');
    ucmThresh = dt.th.ucmThresh;
    superpixels = bwlabel(ucm2 < ucmThresh);
    lim = superpixels(2:2:end, 2:2:end);    
    imagesc(lim);
    
    % modified name
    im_no = str2num(segList(ii).name(end-7:end-4))-5000;
    modified_name = [superpixels_path 'nyud_v2_' num2str(im_no) '.mat'];
    save(modified_name, 'lim');
    
end



%% other preprocessing codes
% for ii=1:length()
%    
%     % point cloud
%     d_name = ['train/nyud_v2_' num2str(trainNdxs(i)) '.mat']; 
%     depth = load(d_name);
%     depth = depth.depth;
%     [r, c] = size(depth);
% 
%     %% 3d data for the current image
%     dz = 100*depth;          % I changed it to scale by 100 since Perceptual Organization does so. I checked their provided point clouds it ranges in the centimeter.
%     [xc, yc] = meshgrid(1:c, 1:r);
%     dx = (xc-par.cx_rgb).*dz/par.fx_rgb; 
%     dy = (yc-par.cy_rgb).*dz/par.fy_rgb;
% 
%     % save the point cloud
%     pc = zeros(r,c,3);
%     pc(:,:,1) = dx;
%     pc(:,:,2) = dy;
%     pc(:,:,3) = dz;
% 
%     save(['train/pc/nyud_v2_' num2str(trainNdxs(i)) '.mat'], 'pc');
% 
% end
