% CS194-26 Final Project: High Dynamic Range
% Name:  Japheth Wong and Akshay Narayan
% Login: cs194-fb and cs194-ka

function main()
    % Sample 1: Station (Source)
    directory = 'station';
    [linear_result, global_result, durand_result] = create_hdr_image(50, 0.09, 5, 0.6, directory, 'jpg');

%     figure, imshow(linear_result);
%     figure, imshow(global_result);
%     figure, imshow(durand_result);

    imwrite(im2uint8(linear_result), ['output/', directory, '_linear_hdr.jpg'], 'jpg');
    imwrite(im2uint8(global_result), ['output/', directory, '_global_hdr.jpg'], 'jpg');
    imwrite(im2uint8(durand_result), ['output/', directory, '_durand_hdr.jpg'], 'jpg');
    
    % Sample 2: Aviemore (Mine)
    directory = 'aviemore';
    [linear_result, global_result, durand_result] = create_hdr_image(50, 0.54, 5, 0.7, directory, 'jpg');

%     figure, imshow(linear_result);
%     figure, imshow(global_result);
%     figure, imshow(durand_result);

    imwrite(im2uint8(linear_result), ['output/', directory, '_linear_hdr.jpg'], 'jpg');
    imwrite(im2uint8(global_result), ['output/', directory, '_global_hdr.jpg'], 'jpg');
    imwrite(im2uint8(durand_result), ['output/', directory, '_durand_hdr.jpg'], 'jpg');
    
    % Sample 3: Aviemore 2 (Mine)
    directory = 'aviemore2';
    [linear_result, global_result, durand_result] = create_hdr_image(50, 0.54, 5, 0.7, directory, 'jpg');

%     figure, imshow(linear_result);
%     figure, imshow(global_result);
%     figure, imshow(durand_result);

    imwrite(im2uint8(linear_result), ['output/', directory, '_linear_hdr.jpg'], 'jpg');
    imwrite(im2uint8(global_result), ['output/', directory, '_global_hdr.jpg'], 'jpg');
    imwrite(im2uint8(durand_result), ['output/', directory, '_durand_hdr.jpg'], 'jpg');
end