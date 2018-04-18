uses crt,dos;
var a:array[1..277] of string;
    st,st1,st2,st3,s:string;
    filename,filename1:string;
    f:text;
    k,m,m1,x,y,code,bg,txt:byte;
    ch,ch1,ch2:char;
    i,i1,n:integer;
    chk:boolean;
function strnum(s:string):boolean;
var a,b:longint;
begin
val(s,a,b);
if b<>0 then strnum:=false
else strnum:=true;
end;
procedure readfile;
var dirinfo:searchrec;
    c,i,b:byte;
    x:array[1..277] of string;
    ch3:char;
begin
{$S-}
     c:=1;b:=1;ch3:=#0;
     clrscr;
     findfirst('*.*',archive,dirinfo);
     while (doserror=0) and (c<278) do
     begin
          x[c]:=dirinfo.name;
          c:=c+1;
          findnext(dirinfo);
     end;
     c:=c-1;
     if c>24 then
        while ch3<>chr(27) do
        begin
             clrscr;
             for i:=b to b+y-2 do
                 writeln(x[i]);
             repeat
                 ch3:=readkey;
             until (ch3=#72) or (ch3=#80) or (ch3=chr(27));
             if (ch3=#72) and (b>=1) then b:=b-1;
             if (ch3=#80) and (b+y-2<=c) then b:=b+1;
             if b=0 then b:=c-y+2;
             if b=c-y+3 then b:=1;
        end;
     if c<=y-1 then
        for i:=1 to n do
            writeln(x[i]);
end;
function checkfile(filename:string):boolean;
var f:text;
        c:boolean;
begin
{$I-}
     assign(f,filename);
     reset(f);
     if IOResult=0 then c:=true
     else c:=false;
{$I+}
     checkfile:=c;
     if c=true then close(f);
     if filename='' then checkfile:=false;
end;
procedure calibrate(st:string;s:byte);
var k:byte;
begin
        for k:=1 to (s-length(st)) div 2 do
                write(' ');
        writeln(st);
end;
procedure menu1;
var k:byte;
begin
        clrscr;
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('NPLite',x);
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('Hit 1 to read and modify or continue',x);
        calibrate('Hit 2 to create a new file',x);
        calibrate('Hit 3 to rename',x);
        calibrate('Hit 4 to delete',x);
        calibrate('Hit 5 to see the manual',x);
        calibrate('Hit 6 to access user preference',x);
        calibrate('Hit esc to exit',x);
        calibrate('UPDATE 3.0',x);
end;
procedure menu2;
var k:byte;
begin
clrscr;
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('User Preference',x);
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('Hit 1 to use night mode(black background,white text)',x);
        calibrate('Hit 2 to use classic mode(white background,black text)',x);
        if chk=true then
                calibrate('Hit 3 to turn off the number before each row',x)
                else
                calibrate('Hit 3 to turn on the number before each row',x);
        calibrate('Hit 4 to trigger widescreen mode',x);
        calibrate('Press esc to return to menu',x);
end;
procedure menu3;
var k:byte;
begin
        clrscr;
        for k:=1 to x-1 do
                write('-');
        writeln;
        calibrate('MANUAL',x);
        for k:=1 to x-1 do
                write('-');;
        writeln;
        writeln('Mode 1:');
        writeln('Type "end" to save end exit');
        writeln('Type "edit" to modify a row,then specify the row');
        writeln('Type "del" to delete a row');
        writeln('Type "insert" to insert a blank row,then specify the location');
        writeln('Type "continue" to continue typing,then type end to save and exit');
        writeln('Type "findword" to find a word in the file,then type that word');
        writeln('Type "replace" to replace a word,then type the word that you want to replace,then type the replacement word');
        writeln('Type "copy" to copy a line,then indicate the line you want to copy');
        writeln('Type "cut" to cut a line,then indicate the line you want to cut');
        writeln('Type "paste" to paste a line,then indicate the line you want to paste');
        writeln('Press arrow keys to scroll');
        writeln('Press esc to show command line');
        writeln('Mode 2:');
        writeln('Type "end" to save and exit');
        writeln('Hit enter to go back to menu');
end;

begin
     x:=80;y:=25;bg:=15;txt:=0;
     textcolor(txt);
     textbackground(bg);
     lowvideo;
     clrscr;
     chk:=true;
     repeat
           st:=#0;
           clrscr;
           menu1;
           repeat
                ch:=readkey;
           until (ch='1') or (ch='2') or (ch='3') or (ch='4') or (ch='5') or (ch='6') or (ch=chr(27));
           if ch='6' then
                repeat
                        menu2;
                        repeat
                                ch2:=readkey;
                        until (ch2='1') or (ch2='2') or (ch2='3') or (ch2='4') or (ch2=chr(27));
                        if ch2='3' then
                        begin
                                if chk=true then chk:=false
                                else chk:=true;
                        end;
                        if ch2='1' then
                        begin
                                txt:=15;
                                bg:=0;
                                textcolor(txt);
                                textbackground(bg);
                                lowvideo;
                                clrscr;
                        end;
                        if ch2='2' then
                        begin
                                txt:=0;
                                bg:=15;
                                textcolor(txt);
                                textbackground(bg);
                                lowvideo;
                                clrscr;
                        end;
                        if ch2='4' then
                                if (x=80) and (y=25) then
                                begin
                                        x:=120;
                                        y:=30;
                                end
                                else
                                begin
                                        x:=80;
                                        y:=25;
                                end;
                until ch2=chr(27);
           if ch='5' then
                repeat
                        menu3;
                        ch:=readkey;
                until ch=chr(13);
           if ch='4' then
           begin
                readfile;
                writeln('Type the filename');readln(filename);
                if checkfile(filename)=false then
                begin
                     clrscr;
                     writeln('File does not exist');
                     writeln('Press enter to go back to menu');
                     readln;
                end
                else
                begin
                assign(f,filename);
                erase(f);
                end;
           end;
           if ch='3' then
           begin
                readfile;
                writeln('Type the filename');readln(filename);
                if checkfile(filename)=true then
                begin
                     writeln('Type the new filename');readln(filename1);
                     assign(f,filename);
                     rename(f,filename1);
                end
                else
                begin
                     clrscr;
                     writeln('File does not exist');
                     writeln('Press enter to go back to menu');
                     readln;
                end;
           end;
           if ch='2' then
           begin
                clrscr;
                writeln('Type the filename');readln(filename);
                assign(f,filename);
                rewrite(f);
                close(f);
                clrscr;
                repeat
                      assign(f,filename);
                      append(f);
                      readln(st);
                      if st<>'end' then writeln(f,st);
                      close(f);
                until st='end';
           end;
           if ch='1' then
           begin
                readfile;
                st1:=#0;
                filename:=#0;m:=1;m1:=1;
                writeln('Type the filename');readln(filename);
                if checkfile(filename)=false then
                begin
                     clrscr;
                     writeln('File does not exist');
                     writeln('Press enter to go back to menu');
                     readln;
                end
                else
                begin
                     clrscr;
                     while st<>'end' do
                     begin
                          for i:=1 to 277 do
                              for i1:=1 to 255 do
                              a[i][i1]:=' ';
                          n:=0;
                          assign(f,filename);
                          reset(f);
                          repeat
                                n:=n+1;
                                readln(f,a[n]);
                          until (eof(f)) or (n=277);
                          close(f);
                          ch1:=#0;k:=0;
                          if m=0 then m:=n-y+2;
                          if m=n-y+3 then m:=1;
                          if n>y-1 then
                                while ch1<>chr(27) do
                                begin
                                        gotoxy(1,1);
                                        if chk=true then
                                                for i:=m to m+y-2 do
                                                begin
                                                        lowvideo;
                                                        if (st='findword') and (pos(st1,a[i])>0) then
                                                        begin
                                                                textcolor(bg);
                                                                textbackground(txt);
                                                                lowvideo;
                                                        end;
                                                        if i<10 then write(i,'   ');
                                                        if (10<=i) and (i<100) then write(i,'  ');
                                                        if i>=100 then write(i,' ');
                                                        for i1:=m1 to m1+x-6 do
                                                                write(a[i][i1]);
                                                        textcolor(txt);
                                                        textbackground(bg);
                                                        lowvideo;
                                                        writeln;
                                                end
                                        else
                                                for i:=m to m+y-2 do
                                                begin
                                                        if (st='findword') and (pos(st1,a[i])>0) then
                                                        begin
                                                                textcolor(bg);
                                                                textbackground(txt);
                                                                lowvideo;
                                                        end;
                                                        for i1:=m1 to m1+x-2 do
                                                                write(a[i][i1]);
                                                        textcolor(txt);
                                                        textbackground(bg);
                                                        lowvideo;
                                                        writeln;
                                                end;
                                        repeat
                                                ch1:=readkey;
                                        until (ch1=#72) or (ch1=#80) or (ch1=#75) or (ch1=#77) or (ch1=chr(27));
                                        if (ch1=#72) and (m>=1) then m:=m-1;
                                        if (ch1=#80) and (m+y-2<=n) then m:=m+1;
                                        if (ch1=#75) and (m1>1) then m1:=m1-1;
                                        if (ch1=#77) and (m1+x-2<255) then m1:=m1+1;
                                        if m=0 then m:=n-y+2;
                                        if m=n-y+3 then m:=1;
                                end;
                          if n<=y-1 then
                                while ch1<>chr(27) do
                                begin
                                        clrscr;
                                        if chk=true then
                                                for i:=1 to n do
                                                begin
                                                        if (st='findword') and (pos(st1,a[i])>0) then
                                                        begin
                                                                textcolor(bg);
                                                                textbackground(txt);
                                                                lowvideo;
                                                        end;
                                                        if i<10 then write(i,'  ');
                                                        if (10<=i) then write(i,' ');
                                                        for i1:=m1 to m1+x-6 do
                                                                write(a[i][i1]);
                                                        textcolor(txt);
                                                        textbackground(bg);
                                                        lowvideo;
                                                         writeln;
                                                end
                                        else
                                                for i:=1 to n do
                                                begin
                                                        if (st='findword') and (pos(st1,a[i])>0) then
                                                        begin
                                                                textcolor(bg);
                                                                textbackground(txt);
                                                                lowvideo;
                                                        end;
                                                        for i1:=m1 to m1+x-2 do
                                                                write(a[i][i1]);
                                                        textcolor(txt);
                                                        textbackground(bg);
                                                        lowvideo;
                                                        writeln;
                                                end;
                                        repeat
                                                ch1:=readkey;
                                        until (ch1=#75) or (ch1=#77) or (ch1=chr(27));
                                        if (ch1=#75) and (m1>1) then m1:=m1-1;
                                        if (ch1=#77) and (m1+x-2<255) then m1:=m1+1;
                                end;
                          write('>');
                          readln(st);
                          if st='edit' then
                          begin
                                repeat
                                        write('edit>');
                                        readln(s);
                                until strnum(s)=true;
                                val(s,k,code);
                                write('edit>',k,'>');
                                readln(a[k]);
                                assign(f,filename);
                                rewrite(f);
                                for i:=1 to n do
                                        writeln(f,a[i]);
                                close(f);
                          end;
                          if st='del' then
                          begin
                                repeat
                                        write('del>');
                                        readln(s);
                                until strnum(s)=true;
                                val(s,k,code);
                                for i:=k to n-1 do
                                        a[i]:=a[i+1];
                                n:=n-1;
                                assign(f,filename);
                                rewrite(f);
                                for i:=1 to n do
                                        writeln(f,a[i]);
                                close(f);
                          end;
                          if st='continue' then
                          begin
                                clrscr;
                                for i:=1 to n do
                                        writeln(a[i]);
                                while st1<>'end' do
                                begin
                                        assign(f,filename);
                                        append(f);
                                        readln(st1);
                                        if st1<>'end' then writeln(f,st1);
                                        close(f);
                                end;
                          end;
                          if st='insert' then
                          begin
                                repeat
                                        write('insert>');
                                        readln(s);
                                until strnum(s)=true;
                                val(s,k,code);
                                for i:=n downto k do
                                         a[i+1]:=a[i];
                                a[k]:=' ';
                                n:=n+1;
                                assign(f,filename);
                                rewrite(f);
                                for i:=1 to n do
                                        writeln(f,a[i]);
                                close(f);
                          end;
                          if st='findword' then
                          begin
                                write('findword>');
                                readln(st1);
                          end;
                          if st='copy' then
                          begin
                                repeat
                                        write('copy>');
                                        readln(s);
                                until strnum(s)=true;
                                val(s,k,code);
                                st3:=a[k];
                          end;
                          if st='paste' then
                          begin
                                repeat
                                        write('paste>');
                                        readln(s);
                                until strnum(s)=true;
                                val(s,k,code);
                                a[k]:=st3;
                                assign(f,filename);
                                rewrite(f);
                                for i:=1 to n do
                                        writeln(f,a[i]);
                                close(f);
                          end;
                          if st='cut' then
                          begin
                                repeat
                                        write('cut>');
                                        readln(s);
                                until strnum(s)=true;
                                val(s,k,code);
                                st3:=a[k];
                                a[k]:=' ';
                                assign(f,filename);
                                rewrite(f);
                                for i:=1 to n do
                                        writeln(f,a[i]);
                                close(f);
                          end;
                          if st='replace' then
                          begin
                                write('replace>');
                                readln(st1);
                                write('replace>',st1,'>');
                                readln(st2);
                                for i:=1 to n do
                                        while pos(st1,a[i])>0 do
                                        begin
                                                k:=pos(st1,a[i]);
                                                delete(a[i],k,length(st1));
                                                insert(st2,a[i],k);
                                        end;
                                assign(f,filename);
                                rewrite(f);
                                for i:=1 to n do
                                        writeln(f,a[i]);
                                close(f);
                          end;
                     end;
                end;
           end;
     until ch=chr(27);
end.

