DB="tasks.txt"

add_task() {
    echo "$1" >> "$DB"
    echo "已添加任务: $1"
}

list_tasks() {
    echo "=== 当前任务 ==="
    nl -ba "$DB"
}

delete_task() {
    sed -i "$1d" "$DB"
    echo "已删除第 $1 条任务"
}

case "$1" in
    add)
        shift
        add_task "$*"
        ;;
    list)
        list_tasks
        ;;
    del)
        delete_task "$2"
        ;;
    *)
        echo "用法："
        echo "./todo.sh add 任务内容"
        echo "./todo.sh list"
        echo "./todo.sh del 任务编号"
        ;;
esac