package main

// build:
// GOARCH=amd64 GOOS=linux go build -o strange
// GOARCH=amd64 GOOS=windows go build -o strange.exe
import (
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"
)

const TEX_EXT = ".tex"
const PACKAGE_PATH = "shared/preamble"
const LOCAL_PACKAGE_Name = ".strange.sty"

var rootPath = "./"
var absPackagePath = PACKAGE_PATH

func main() {
	if len(os.Args) > 1 {
		rootPath = os.Args[1]
	}
	rootPath, err := filepath.Abs(rootPath) // get abs path of workspace root.
	if err != nil {
		log.Fatal(err)
	}

	absPackagePath = filepath.Join(rootPath, PACKAGE_PATH)
	err = filepath.Walk(rootPath, processorDir)
	if err != nil {
		log.Fatal(err)
	}
}

func processorDir(path string, info os.FileInfo, err error) error {
	if info.IsDir() {
		files, err := ioutil.ReadDir(path)
		if err != nil {
			return err
		}

		// see all files in this dir.
		hasTex := false
		for _, f := range files {
			if !f.IsDir() && filepath.Ext(f.Name()) == TEX_EXT {
				hasTex = true;
			}
		}

		if hasTex {
			localPackagePath := filepath.Join(path, LOCAL_PACKAGE_Name)
			if packageFile, err := os.Create(localPackagePath); err != nil {
				return err
			} else {
				packageFile.WriteString(`\ProvidesPackage{.strange}
\usepackage{` + strings.Replace(absPackagePath, "\\", "/", -1) + "}") // convert path to linux style.
			}
		}
	}
	return nil
}
