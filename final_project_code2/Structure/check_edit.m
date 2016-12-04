%%
function user_entry = check_edit(h,min_v,max_v,default,h_edit)
    % This function will check the value typed in the text input box
    % against min and max values, and correct errors.
    %
    % h: handle of gui
    % min_v min value to check
    % max_v max value to check
    % default is the default value if user enters non number
    % h_edit is the edit value to update.
    %
    user_entry = str2double(get(h,'string'));
    if isnan(user_entry)
        errordlg(['You must enter a numeric value, defaulting to ',num2str(default),'.'],'Bad Input','modal')
        set(h_edit,'string',default);
        user_entry = default;
    end
    %
    if user_entry < min_v
        errordlg(['Minimum limit is ',num2str(min_v),' degrees, using ',num2str(min_v),'.'],'Bad Input','modal')
        user_entry = min_v;
        set(h_edit,'string',user_entry);
    end
    if user_entry > max_v
        errordlg(['Maximum limit is ',num2str(max_v),' degrees, using ',num2str(max_v),'.'],'Bad Input','modal')
        user_entry = max_v;
        set(h_edit,'string',user_entry);
    end
end
%