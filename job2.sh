
if [ "$#" -ne 2 ]; then
    echo "Utilisation : $0 <date_debut> <date_fin>"
    exit 1
fi
date_debut="$1"
date_fin="$2"
backup_dir="/var/backup"
[ ! -d "$backup_dir" ] && mkdir -p "$backup_dir"
recuperer_connexions() {
    sed -n "/$date_debut/,/$date_fin/p" "/var/log/auth.log" > "$backup_dir/recuperation-$date_debut-$date_fin.log"
}
recuperer_connexions "$date_debut" "$date_fin"
tar -czf "$backup_dir/recuperation-$(date +%d-%b-%Y).tar.gz" -C "$backup_dir" "recuperation-$date_debut-$date_fin.log"
rm "$backup_dir/recuperation-$date_debut-$date_fin.log"
chmod +x script-recuperation.sh