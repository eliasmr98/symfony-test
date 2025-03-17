
if [ ! -f .env.local ]
	then
    	# override .env.local
    	echo "Creating .env.local"
		cp override.env.local .env.local
fi

echo "Running pre-env.sh"