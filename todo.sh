#!/bin/bash

DB="tasks.txt"

add_task() {
    echo "$1" >> "$DB"
    echo "已添加任务: $1"
}

list_tasks() {
    echo "=== 当前任务 ==="
    if [ ! -s "$DB" ]; then
        echo "(无任务)"
    else
        nl -ba "$DB"
    fi
}

delete_task() {
    local line_num="$1"
    # 验证输入是正整数
    case "$line_num" in
        ''|0|*[!0-9]*)
            echo "错误：任务编号必须是正整数" >&2
            exit 1
            ;;
    esac

    # 检查文件是否存在且行数足够
    if [ ! -f "$DB" ] || [ "$(wc -l < "$DB")" -lt "$line_num" ]; then
        echo "错误：任务编号 $line_num 不存在" >&2
        exit 1
    fi

    # 安全删除（可选：保留备份）
    sed -i "$line_num d" "$DB"
    echo "已删除第 $line_num 条任务"
}

# 主逻辑
case "$1" in
    add)
        shift
        if [ -z "$*" ]; then
            echo "错误：任务内容不能为空" >&2
            exit 1
        fi
        add_task "$*"
        ;;
    list)
        list_tasks
        ;;
    del)
        if [ -z "$2" ]; then
            echo "错误：请提供任务编号" >&2
            exit 1
        fi
        delete_task "$2"
        ;;
    *)
        echo "用法："
        echo "  $0 add 任务内容"
        echo "  $0 list"
        echo "  $0 del 任务编号"
        exit 1
        ;;
esac