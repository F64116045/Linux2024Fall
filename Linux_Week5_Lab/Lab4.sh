student_list=$(cat student_id)


mkdir -p "compressed_files/zip"
mkdir -p "compressed_files/rar"
mkdir -p "compressed_files/tar.gz"
mkdir -p "compressed_files/unknown"


touch missing_list
touch wrong_list


if [ -d "compressed_files" ]; then
    for file in compressed_files/*; do
        if [ -f "$file" ]; then
            if [[ "$file" == *.zip ]]; then
                mv "$file" compressed_files/zip/
                unzip compressed_files/zip/$(basename "$file") -d compressed_files/zip/ 
                rm compressed_files/zip/$(basename "$file")  
            elif [[ "$file" == *.rar ]]; then
                mv "$file" compressed_files/rar/
                unrar x compressed_files/rar/$(basename "$file") compressed_files/rar/  
                rm compressed_files/rar/$(basename "$file")  
            elif [[ "$file" == *.tar.gz ]]; then
                mv "$file" compressed_files/tar.gz/
                tar -xzf compressed_files/tar.gz/$(basename "$file") -C compressed_files/tar.gz/ 
                rm compressed_files/tar.gz/$(basename "$file")
            else
                mv "$file" compressed_files/unknown/
            fi
        fi
    done
else
    echo "找不到目錄：compressed_files"
    exit 1
fi

for student_id in $student_list; do
    # 檢查學生是否提交了文件
    if ls compressed_files/* | grep -q "$student_id"; then
        # 如果提交了文件，檢查文件格式是否正確 (.zip, .rar, .tar.gz)
        if ! ls compressed_files/{zip,rar,tar.gz}/* | grep -q "$student_id"; then
            echo "$student_id" >> wrong_list  # 如果格式不對，記錄到 wrong_list
        fi
    else
        echo "$student_id" >> missing_list  # 如果未提交，記錄到 missing_list
    fi
done