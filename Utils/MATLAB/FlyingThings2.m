% % FlyingThings(200, '/media/zwu/ECC2DD2BC2DCFB32/Flythings3d','/media/zwu/ECC2DD2BC2DCFB32/Flythings3d')
function FlyingThings(max_coc, path, savepath)

% focal length, apeture, pixel size, focus distance
camera_params = [0.035, 0.1, 959/0.032, 10];


% Train set 
% for subset = ["A","B","C"]
% for scene_num = 198:749
%     
%     if exist(fullfile(path, '/frames/flythings3d/', 'TRAIN', subset, num2str(scene_num, '%04d')),'dir')
% %         a = fullfile(path, '/frames/flythings3d/', 'TRAIN', subset, num2str(scene_num, '%04d'))
% 	    for lr = ["left","right"]
%             mkdir(fullfile(savepath, '/dof/flythings3d/', 'TRAIN', subset, num2str(scene_num, '%04d'), lr))
%             mkdir(fullfile(savepath, '/decomposed_depth/flythings3d/', 'TRAIN', subset, num2str(scene_num, '%04d'), lr))
%             for img_num = 6:15
%                 image_file_paths = fullfile(path, '/frames/flythings3d/', 'TRAIN', subset, num2str(scene_num, '%04d'), lr, [num2str(img_num, '%04d'), '.png']);
%                 depth_file_paths = fullfile(path, '/disp/flythings3d/', 'TRAIN', subset, num2str(scene_num, '%04d'), lr, [num2str(img_num, '%04d'), '.pfm']);
%                 dof_save = fullfile(savepath, '/dof/flythings3d/', 'TRAIN', subset, num2str(scene_num, '%04d'), lr, [num2str(img_num, '%04d'), '.png'])
%                 decomposed_depth_save = fullfile(savepath, '/decomposed_depth/flythings3d/', 'TRAIN', subset, num2str(scene_num, '%04d'), lr, [num2str(img_num, '%04d'), '.pfm']);
%                 One_generate_blur_by_depth(camera_params, max_coc, image_file_paths, depth_file_paths, dof_save, decomposed_depth_save, false, 2)
%             end
%         end
%     end
% 
% 
% end
% end

% Test set
for subset = ["A","B","C"]
for scene_num = 0:149
    if exist(fullfile(path, '/frames/flythings3d/', 'TEST', subset, num2str(scene_num, '%04d')),'dir')
        for lr = ["left","right"]
            mkdir(fullfile(savepath, '/dof/flythings3d/', 'TEST', subset, num2str(scene_num, '%04d'), lr))
            mkdir(fullfile(savepath, '/decomposed_depth/flythings3d/', 'TEST', subset, num2str(scene_num, '%04d'), lr))
            for img_num = 6:15
                image_file_paths = fullfile(path, '/frames/flythings3d/', 'TEST', subset, num2str(scene_num, '%04d'), lr, [num2str(img_num, '%04d'), '.png']);
                depth_file_paths = fullfile(path, '/disp/flythings3d/', 'TEST', subset, num2str(scene_num, '%04d'), lr, [num2str(img_num, '%04d'), '.pfm']);
                dof_save = fullfile(savepath, '/dof/flythings3d/', 'TEST', subset, num2str(scene_num, '%04d'), lr, [num2str(img_num, '%04d'), '.png'])
                decomposed_depth_save = fullfile(savepath, '/decomposed_depth/flythings3d/', 'TEST', subset, num2str(scene_num, '%04d'), lr, [num2str(img_num, '%04d'), '.pfm']);
                One_generate_blur_by_depth(camera_params, max_coc, image_file_paths, depth_file_paths, dof_save, decomposed_depth_save, false, 2)
            end
        end
    end
end
end



end