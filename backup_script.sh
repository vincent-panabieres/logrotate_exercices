create_backup() {
    local source_dir="$1"
    local backup_prefix="$2"
    local timestamp=$(date +%d-%b-%Y)
    local user="$3"
    tar czf "$backup_dir/$user-$backup_prefix-$timestamp.tar.gz" -C "$source_dir" .
}
if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
fi
for user_home in /home/*; do
    username=$(basename "$user_home")
    user_backup_dir="$backup_dir/$username"
    if [ ! -d "$user_backup_dir" ]; then
        mkdir -p "$user_backup_dir"
    fi
    create_backup "$user_home" "fichiers-moins-7-jours" "$username"
    create_backup "$user_home" "fichiers-plus-7-jours" "$username"
    find "$user_home" -type d -exec du -sh {} + | awk -F $'\t' '$1 > 10M {print $2}' | while read -r large_dir; do
        create_backup "$large_dir" "repertoires-plus-10Mo" "$username"
    done
    create_backup "$user_home" "fichiers-repertoires-caches" "$username"
    chown -R "$username:$username" "$user_backup_dir"
done
