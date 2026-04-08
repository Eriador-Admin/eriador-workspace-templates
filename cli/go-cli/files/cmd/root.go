package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "{{CLI_NAME}}",
	Short: "A CLI tool built with Cobra",
	Long:  "{{CLI_NAME}} is a command-line tool scaffolded with Go and Cobra.",
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
