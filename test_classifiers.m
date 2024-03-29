function [cnames,error] = test_classifiers(sample_size,minimum)

    % The classifiers that need to be tested
    %classifiers = {qdc,knnc([],1), bpxnc(2, 1000), svc, fisherc, ldc, klldc, lkc, lmnc, loglc, lssvc, nmc, nmsc, nusvc, perlc, polyc, qdc, rbnc, rssvc, parzenc};
    classifiers = {...
        knnc,...
        lkc, ...
        dtc, ...
        fisherc, ...
        ldc, ...
        klldc, ...
        loglc, ...
        naivebc, ...
        nmc, ...
        nmsc, ...
        perlc, ...
        polyc, ...
        qdc,...
        vpc([],10000),...
         udc,...
        rsscc,...
        pcldc,...
         parzenc};
     
     names = {...
        'knnc',...
        'lkc', ...
        'dtc', ...
        'fisherc', ...
        'ldc', ...
        'klldc', ...
        'loglc', ...
        'naivebc', ...
        'nmc', ...
        'nmsc', ...
        'perlc', ...
        'polyc', ...
        'qdc',...
        'vpc',...
        'udc',...
        'rsscc',...
        'pcldc',...
        'parzenc'};
 
    error=[];
    time =[];
    cnames = [];

    [HOG,PCA]   = loadData(sample_size);
    for classifier = classifiers
        classifier = classifier{1}
        %[e,d] = crossval(dataset, classifier, 20);
        w           = classifier(HOG*PCA);
        e = nist_eval('dig_2_data',PCA*w,100)
        
        tic;
        error(length(error)+1) = e;
        time(length(time)+1) = toc;
    end

    best = find(error == min(error));
    classifiers{best}
    error(best)
    
    fig = figure;
    scatter(error,time,75,'filled','b')
    
    for i = 1:18
        text(error(i)+0.0005,time(i),names(i),'FontSize',11);
    end
    
    line([minimum,minimum],[0,1],'color','r');
    
    %axis([0.05 0.9 .000022 .00005])
    
    names
    error
    time
    %disp(classifiers{best});
end