sw() {
	{
		echo "NEW WORK"
		echo "$PWD"
		fc -ln -8
		echo "END OF NEW WORK"
	} >> ~/work
}

cw() {
	cat ~/work
}

rmw() {
	if [[ ! -f ~/work ]]; then
		echo "No work, exiting"
		return
	fi
	if [[ $(stat -c%s "$HOME/work") == 0 ]]; then
		echo "Work file is empty"
		rm ~/work
		return
	fi
	echo "!!! WARNING !!!"
	echo "Work file not empty, contents:"
	cw
	read -p "Delete work file anyway? " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "Removing work file"
		rm ~/work
		return
	fi
	echo "Leaving work file as is"
}

dw() {
	if [[ ! -f ~/work ]]; then
		echo "No work, exiting"
		return
	fi

	mapfile -t blocks < <(grep -n "^NEW WORK$" ~/work | cut -d: -f1)

	if [[ ${#blocks[@]} == 0 ]]; then
		echo "No work extracted, check file and retry"
		return
	fi

	echo "Found ${#blocks[@]} job(s):"
	
	for i in "${!blocks[@]}"; do
		start=${blocks[i]}
		end=$(awk "NR>${start} && /^END OF NEW WORK\$/{print NR; exit}" ~/work)
		echo "[$i] ---"
		awk -v s="$start" -v e="$end" 'NR > s && NR < e' ~/work
	done

	read -p "Index of the compleated job: " index
	if ! [[ "$index" =~ ^[0-9]+$ ]] || (( index < 0 || index >= ${#blocks[@]} )); then
		echo "invalid index, exiting"
		return
	fi

	start=${blocks[index]}
	end=$(awk "NR>${start} && /^END OF NEW WORK\$/{print NR; exit}" ~/work)

	if [[ -z "$end" ]]; then
		echo "could not find END OF NEW WORK, exiting"
		return
	fi

	echo "! Warning !"
	echo "Delete this job?"
	awk -v s="$start" -v e="$end" 'NR > s && NR < e' ~/work

	read -p "Confirm? " -n 1 -r
	echo
	if [[ ! $REPLY =~ ^[Yy]$ ]]; then
		echo "Aborting"
		return
	fi

	awk -v s="$start" -v e="$end" 'NR<s || NR>e' ~/work > ~/work.tmp
	mv ~/work.tmp ~/work
	echo "removed"
}

