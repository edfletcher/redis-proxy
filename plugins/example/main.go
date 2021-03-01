package main

import (
	"net/url"
)

func Version() string {
	return "0.0.1"
}

func HandleMsg(payload interface{}) (interface{}, error) {
	return "", nil
}

func HandleListReq(dir string, file string, query url.Values, listLookup RhpHandleListReqLookupFunc) (string, error) {
	return "", nil
}
