function [data1,data2] = fixedAndNewton(f,iterations,tolerance,handles,hObject)
        x0 =  get(handles.edit6,'String');
           if(isempty(x0))
                return
           else
               x0 = str2double(x0);
               if(strcmp (handles.cell , 'All methods'))
                tem = sym(f);
                dfn = diff(tem);
                dfn = char(dfn);
                [err,table] = Newton(f, dfn,x0,tolerance,iterations);
                if(err == 0)
                     set(handles.text15,'String',strcat(get(handles.text15,'String'),'Newton,'));
                     data1 = [];
                else
                     figure;
                     plot(table(:,8),table(:,1),'k+:');
                     axes(handles.axes1);
                     plot(table(:,1),table(:,3),'g')
                     hold on;
                     data1 = table;
                end
                [err2,table2] = Fixed(f,x0,tolerance , iterations);
                if(err2 == 1)
                     set(handles.text15,'String',strcat(get(handles.text15,'String'),'FixedPoint,'));
                     data2 = [];
                else
                    data2 = table2;
                    plot(table2(:,1),table2(:,3),'c')
                     hold on;
                end
               elseif(strcmp (handles.cell , 'Newton-Raphson'))
                tem = sym(f);
                dfn = diff(tem);
                tempdfn = dfn;
                dfn = char(dfn);
                [err,tableData] = Newton(f, dfn,x0,tolerance,iterations);
                 if(err == 0)
                     set(handles.text15,'String',strcat(get(handles.text15,'String'),'Newton,'));
                 else
                    derivatePlot(tempdfn,tableData,3)%assume roots in column 3
                    set(handles.uitable1,'data',tableData);
                    %check names.
                    %disp('  step                    x                       f              df/dx            Sigma        SigmaABS');
                    set(handles.uitable1,'ColumnName',{'step', 'execution time', 'x','f','df/dx', 'Absolute error', 'Sigma', 'Theoritical Error'}); 
                    set(handles.text6,'String','Theoritical Error');
                    set(handles.text5,'String',tableData(1,end));
                 end
               elseif(strcmp (handles.cell , 'Fixed point'))
                   [err2,tableData] = Fixed(f,x0,tolerance , iterations);
                    if(err2 == 1)
                        set(handles.text6,'String','FixedPoint');
                        set(handles.text5,'String','may be converge or may be diverge');
                    else
                       %don't understand '(x2-x1)/x2'
                       set(handles.text6,'String','FixedPoint');
                       set(handles.text5,'String','converge');
                       set(handles.uitable1,'ColumnName',{'i', 'x1', 'root', 'absolute error','time'});
                       set(handles.uitable1,'data',tableData); 
                    end
               end
           end
end