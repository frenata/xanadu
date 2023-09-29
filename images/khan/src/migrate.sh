DIR=/src/migrations

for file in $(ls $DIR | sort)
do
	psql -U postgres < "$DIR/$file"
done
