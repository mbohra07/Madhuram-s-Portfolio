#!/bin/bash

# Portfolio Website Deployment Script
# This script helps you deploy your portfolio to various platforms

echo "🚀 Portfolio Website Deployment Helper"
echo "======================================"

# Check if required files exist
required_files=("index.html" "styles.css" "script.js")
missing_files=()

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        missing_files+=("$file")
    fi
done

if [ ${#missing_files[@]} -ne 0 ]; then
    echo "❌ Missing required files:"
    printf '%s\n' "${missing_files[@]}"
    echo "Please ensure all files are in the current directory."
    exit 1
fi

echo "✅ All required files found!"
echo ""

# Display deployment options
echo "Choose your deployment option:"
echo "1. GitHub Pages (requires git repository)"
echo "2. Netlify (manual upload)"
echo "3. Create deployment package"
echo "4. Local preview"
echo "5. Exit"
echo ""

read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo ""
        echo "📚 GitHub Pages Deployment:"
        echo "1. Initialize git repository: git init"
        echo "2. Add files: git add ."
        echo "3. Commit: git commit -m 'Initial portfolio commit'"
        echo "4. Create GitHub repository and add remote"
        echo "5. Push: git push -u origin main"
        echo "6. Enable GitHub Pages in repository settings"
        echo ""
        read -p "Do you want to initialize git repository now? (y/n): " init_git
        if [ "$init_git" = "y" ] || [ "$init_git" = "Y" ]; then
            git init
            git add .
            git commit -m "Initial portfolio commit"
            echo "✅ Git repository initialized and files committed!"
            echo "Now create a GitHub repository and run:"
            echo "git remote add origin https://github.com/yourusername/your-repo.git"
            echo "git push -u origin main"
        fi
        ;;
    2)
        echo ""
        echo "🌐 Netlify Deployment:"
        echo "1. Go to https://netlify.com"
        echo "2. Drag and drop your project folder"
        echo "3. Your site will be live instantly!"
        echo ""
        echo "Or use Netlify CLI:"
        echo "npm install -g netlify-cli"
        echo "netlify deploy --prod --dir ."
        ;;
    3)
        echo ""
        echo "📦 Creating deployment package..."
        
        # Create deployment directory
        deploy_dir="portfolio-deployment-$(date +%Y%m%d-%H%M%S)"
        mkdir "$deploy_dir"
        
        # Copy files
        cp index.html "$deploy_dir/"
        cp styles.css "$deploy_dir/"
        cp script.js "$deploy_dir/"
        cp portfolio-README.md "$deploy_dir/README.md"
        
        # Create zip file
        if command -v zip &> /dev/null; then
            zip -r "${deploy_dir}.zip" "$deploy_dir"
            echo "✅ Deployment package created: ${deploy_dir}.zip"
        else
            echo "✅ Deployment folder created: $deploy_dir"
            echo "Note: zip command not found. Folder created instead of zip file."
        fi
        
        echo ""
        echo "Upload the contents of this folder to your web hosting provider."
        ;;
    4)
        echo ""
        echo "🖥️  Starting local preview..."
        
        # Try to open with different browsers/commands
        if command -v python3 &> /dev/null; then
            echo "Starting Python HTTP server on port 8000..."
            echo "Open http://localhost:8000 in your browser"
            echo "Press Ctrl+C to stop the server"
            python3 -m http.server 8000
        elif command -v python &> /dev/null; then
            echo "Starting Python HTTP server on port 8000..."
            echo "Open http://localhost:8000 in your browser"
            echo "Press Ctrl+C to stop the server"
            python -m SimpleHTTPServer 8000
        elif command -v open &> /dev/null; then
            # macOS
            open index.html
        elif command -v xdg-open &> /dev/null; then
            # Linux
            xdg-open index.html
        elif command -v start &> /dev/null; then
            # Windows
            start index.html
        else
            echo "Please open index.html in your web browser manually."
        fi
        ;;
    5)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "🎉 Deployment process completed!"
echo ""
echo "📋 Next steps:"
echo "- Test your website on different devices"
echo "- Update your contact information"
echo "- Add your projects and experiences"
echo "- Consider adding a custom domain"
echo ""
echo "📞 Need help? Check the README.md file for detailed instructions."
