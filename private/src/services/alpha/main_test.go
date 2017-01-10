package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestSquare(t *testing.T) {
	tcs := []struct {
		in, ex int
	}{
		{0, 0},
		{1, 1},
		{2, 4},
		{8, 64},
	}

	for _, tc := range tcs {
		v := square(tc.in)
		assert.Equal(t, tc.ex, v)
	}
}
