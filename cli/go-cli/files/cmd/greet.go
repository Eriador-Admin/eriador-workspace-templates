package cmd

import (
	"fmt"
	"strings"

	"github.com/spf13/cobra"
)

var (
	greetName  string
	greetShout bool
)

var greetCmd = &cobra.Command{
	Use:   "greet",
	Short: "Greet someone by name",
	Run: func(cmd *cobra.Command, args []string) {
		message := fmt.Sprintf("Hello, %s!", greetName)
		if greetShout {
			message = strings.ToUpper(message)
		}
		fmt.Println(message)
	},
}

func init() {
	greetCmd.Flags().StringVarP(&greetName, "name", "n", "World", "Name to greet")
	greetCmd.Flags().BoolVarP(&greetShout, "shout", "s", false, "Greet in uppercase")
	rootCmd.AddCommand(greetCmd)
}
