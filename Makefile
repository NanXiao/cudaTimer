test: test.cu cudaTimer.cuh
	nvcc -o $@ $<

clean:
	rm -f test