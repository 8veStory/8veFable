#!/bin/bash

# Ask what kind of blog post
echo "What kind of blog post do you want to create?"
echo "1. Blog"
echo "2. Blender"
echo "3. Senior Engineering"
echo "4. Game Dev"
read -p "Blog post type: " blogposttype

# Verify that blogposttype is a number between 1 and 4
if ! [[ "$blogposttype" =~ ^[1-4]$ ]]; then
    echo "Invalid blog post type. It must be a number between 1 and 4. Exiting."
    exit 1
fi

# Ask user for blog post name
echo "What is the name of your blog post?"
read -p "Blog post name: " blogpostname

# Convert blogpostname to lowercase and replace spaces with hyphens
jekyllblogpostname=$(echo "$blogpostname" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# Print blog post name user gave
echo "Creating blog post with name: $jekyllblogpostname"

# Create Jekyll blog post file with date and post name
filename="$(date +%Y-%m-%d)-$jekyllblogpostname.md"

# Set the folder to create the post in based on the type
case $blogposttype in
    1) folder="_posts/blog/" ;;
    2) folder="_posts/blender/" ;;
    3) folder="_posts/engineering/" ;;
    4) folder="_posts/gamedev/" ;;
esac

# Create the blog post file in the right folder
touch "${folder}${filename}"

# Use template for blog post type
case $blogposttype in
    1) template="_posts/templates/1 Blog Template.md" ;;
    2) template="_posts/templates/2 Blender Template.md" ;;
    3) template="_posts/templates/3 Engineer Template.md" ;;
    4) template="_posts/templates/4 Game Dev Template.md" ;;
esac

# Copy the template into the new blog post file
cat "$template" > "${folder}${filename}"

# Replace {{date:YYYY-MM-DD}} with date
sed -i "s/{{date:YYYY-MM-DD}}/$(date +%Y-%m-%d)/g" "${folder}${filename}"

# Replace {{title}} with blog post name
# Use a delimiter other than / for the sed command because $blogpostname may contain / characters
sed -i "s|{{title}}|$blogpostname|g" "${folder}${filename}"
