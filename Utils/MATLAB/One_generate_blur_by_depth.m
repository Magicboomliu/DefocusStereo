function generate_blur_by_depth(camera_params, max_coc, image_file_path, depth_file_path, dof_image_save_path, decomposed_depth_save_path, is_gpu, gpunum)
    g = 0;
    if is_gpu
        disp(['gpu: ', num2str(gpunum)]);
        g = gpuDevice(gpunum);
    end
    % local all
            % image_file_path = '/home/zwu/Downloads/Sampler/FlyingThings3D/RGB_cleanpass/left/0006.png';
            % depth_file_path = '/home/zwu/Downloads/Sampler/FlyingThings3D/disparity/0006.pfm';

            % dof_image_save_path = '/home/zwu/Downloads/Sampler/FlyingThings3D/disparity/0006.png';

%             camera_params = [0.035, 0.1, 959/0.032, 10];
            kernel_type = 'gaussian';
            
            [dof_image, depth_map, camera_params2] = ... 
                blur_by_depth(image_file_path, depth_file_path, 10, kernel_type, max_coc, is_gpu, g, camera_params);
            
            imwrite(dof_image, dof_image_save_path);
            pfmwrite(depth_map, decomposed_depth_save_path);
            
            
            
            %prefix = '';
            % name = 'test';
            %f = num2str(camera_params(1));
            %fp = strrep(num2str(camera_params(4), 2), '.', '_');
            %a = strrep(num2str(camera_params(2), 2), '.', '_');

            % dof_image_save_name = [prefix, name, '.png']
            % dof_image_save_name = [prefix, name, '_f_', f, '_fp_', fp, '_A_', a, '.png']
            %blur_map_save_name = [prefix, name, '_f_', f, '_fp_', fp, '_A_', a, '.png'];
            %blur_map_norm_save_name = [prefix, name, '_f_', f, '_fp_', fp, '_A_', a, '_norm.png'];
            %blur_map_binary_save_name = [prefix, name, '_f_', f, '_fp_', fp, '_A_', a, '_binary.png'];
            %depth_map_name = [prefix, name, '_f_', f, '_fp_', fp, '_A_', a, '_depth_decomposed.png'];
            %imwrite(dof_image, [dof_image_save_path, dof_image_save_name]);
            %imwrite(blur_map, [blur_map_save_path, blur_map_save_name]);
            %imwrite(blur_map_norm, [blur_map_norm_save_path, blur_map_norm_save_name]);
            %imwrite(blur_map_binary, [blur_map_binary_save_path, blur_map_binary_save_name]);
            %imwrite(depth_map, [depth_map_save_path, depth_map_name]);
            
            
end

function full_path = dir2(varargin)
    if nargin == 0
        name = '.';
    elseif nargin == 1
        error('Too few input arguments.')
    elseif nargin == 2
        root = varargin{1};
        pattern = varargin{2};
        name = fullfile(root, pattern);
    else
        error('Too many input arguments.')
    end

    listing = dir(name);

    inds = [];
    n    = 0;
    k    = 1;

    while k <= length(listing)
        if listing(k).isdir
            inds(end + 1) = k;
        end
        k = k + 1;
    end
    listing(inds) = [];

    full_path = [];
    for k = 1:length(listing)
        file_path = listing(k).folder;
        file_name = listing(k).name;
        full_path = [full_path, string(fullfile(file_path, file_name))];
    end
    full_path = sort(full_path);

end

function full_path = dir3(varargin)
    if nargin == 0
        name = '.';
    elseif nargin == 1
        error('Too few input arguments.')
    elseif nargin == 2
        root = varargin{1};
        pattern = varargin{2};
        name = fullfile(root, pattern);
    else
        error('Too many input arguments.')
    end

    allSubFolders = genpath(root);
    % Let's extract all the folders into individual cells in a cell array.
    % That will be easier to use when we need to get the folder name in a loop.
    listOfFolderNames = strsplit(allSubFolders, ';');
    % Strsplit() seems to give an empty string for the last one.  Get rid of any empty folder names.
    emptyCells = cellfun(@isempty, listOfFolderNames);
    listOfFolderNames = listOfFolderNames(~emptyCells);
    numberOfFolders = length(listOfFolderNames);
    % fprintf('The total number of folders to look in is %d\n', numberOfFolders);

    full_path = [];
    totalNumberOfFiles = 0;
    for k = 1 : numberOfFolders
        % Get this folder and print it out.
        thisFolder = listOfFolderNames{k};
        % fprintf('Looking inside folder %s\n', thisFolder);

        % Get ALL files using the pattern *.*
        filePattern = sprintf('%s/*.*', thisFolder);
        baseFileNames = dir(filePattern);
        
        numberOfFiles = length(baseFileNames);
        if numberOfFiles >= 1
            totalNumberOfFiles = totalNumberOfFiles + numberOfFiles;
            % Go through all those files.
            for f = 1 : numberOfFiles
                fullFileName = fullfile(thisFolder, baseFileNames(f).name);
                % Skip files . and .. which are actually folders.
                if isdir(fullFileName)
                    totalNumberOfFiles = totalNumberOfFiles - 1; % Don't count this file
                    continue; % Skip to bottom of loop and continue with loop.
                end
                full_path = [full_path, string(fullFileName)];
                % fprintf('     Processing file %s\n', fullFileName);
            end
        else
            % fprintf('     Folder %s has no files in it.\n', thisFolder);
        end
    end
    full_path = sort(full_path);
end