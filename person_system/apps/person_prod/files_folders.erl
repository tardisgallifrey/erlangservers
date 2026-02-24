
open_dets_file() ->
    FileName = filename:join(["/home", "user", "your_file.dets"]),
    case dets:open_file(FileName, [{type, set}]) of
        {ok, Table} ->
            %% Successfully opened, work with the Table
            Table;
        {error, Reason} ->
            io:format("Failed to open file: ~p~n", [Reason]),
            {error, Reason}
    end.


ensure_directory_exists(Dir) ->
    case file:list_dir(Dir) of
        {ok, _Files} ->
            ok;  % Directory exists
        {error, enoent} ->
            case file:make_dir(Dir) of
                ok -> ok;  % Directory created successfully
                {error, Reason} -> {error, Reason}  % Handle error in creating directory
            end;
        {error, Reason} ->
            {error, Reason}  % Handle other errors
    end.


get_dets_file_path(FileName) ->
    PrivDir = code:priv_dir(your_app_name),  % Replace with your app name
    DetFile = filename:join([PrivDir, "your_dets_files", FileName]),
    DetFile.


open_dets_file(FileName) ->
    DetFile = get_dets_file_path(FileName),
    
    case ensure_directory_exists(filename:dirname(DetFile)) of
        ok ->
            case dets:open_file(DetFile, [{type, set}]) of
                {ok, Table} ->
                    %% Successfully opened, work with the Table
                    Table;
                {error, Reason} ->
                    io:format("Failed to open file: ~p~n", [Reason]),
                    {error, Reason}
            end;
        {error, Reason} ->
            io:format("Failed to ensure directory exists: ~p~n", [Reason]),
            {error, Reason}
    end.


