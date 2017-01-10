package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestIncrement(t *testing.T) {
	tcs := []struct {
		in, ex int
	}{
		{0, 1},
		{1, 2},
		{2, 3},
		{8, 9},
	}

	for _, tc := range tcs {
		v := increment(tc.in)
		assert.Equal(t, tc.ex, v)
	}
}
