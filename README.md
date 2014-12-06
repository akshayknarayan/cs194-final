# CS194-26 Final Project

**Akshay Narayan (cs194-ka) and Japheth Wong (cs194-fb)**

University of California, Berkeley

Prof. Alexei (Alyosha) Efros

## Running Final Project

Our project was partially implemented in MATLAB and partially in Python.  As such, the various pieces of code will need to be executed separately.

To run the **High Dynamic Range** project:
1. In MATLAB, navigate to the hdr directory.
2.  Execute:

```
#!matlab
>> main();
```

To run the **Miniatures** project:
1.  Navigate  to the miniatures directory.
2.  Execute:

```
#!bash
$ python tiltshift.py
```

There is no code associated with the **Vertigo Shot** project.

## High Dynamic Range

### Code Layout

Our MATLAB code is laid out as follows:

* **apply_bilateral_filter.m:** This is a helper function which computes the bilateral filter which we need as part of following Durand's algorithm for tone mapping.

* **apply_linear_tonemap.m:** This is a helper function which computes the baseline tonemap, a basic linear tone mapping.

* **apply_reinhard_global_tonemap.m:** This is a helper function which computes the global tone map which Reinhard proposed in his 2002 paper.

* **apply_tonemap.m:**  This is a helper function which takes the computed display luminance map and applies it to the HDR radiance map.  This basically applies the tone map to the image so that it can be displayed in regular range.

* **compute_hdr_map.m:**  This is a helper function which follows Debevec's algorithm for computing the HDR radiance map.

* **compute_luminance_map.m:**  This is a helper function which recovers the luminance map from the computed HDR radiance map.  This is basically a linear combination of the red, green, and blue channels, following the sRGB equation.

* **compute_weights.m:**  This is a helper function which computes the weights to use in Debevec's algorithm.

* **create_hdr_image.m:**  This is a function which wraps all the logic for recovering an HDR image from a sequence of photos.  This returns a few results, based on different tone maps, to the caller.

* **gsolve.m:**  This is a function provided in Debevec's paper to solve for g, used to recover the HDR radiance.

* **main.m:** This is the main function which is used to execute the project under default settings.  This also displays and writes the final results.

* **read_images.m:** This is a helper function which reads in the images and exposure times for all images in a directory.

* **sample_rgb_images.m:** This is a helper function which constructs the Z matrix of samples to use.  This is necessary because a full-size image has way too many pixels; here, we choose pixels to sample and use in our algorithm.

### References

* [Bilateral Filtering for Gray and Color Images (Tomasi, IEEE 1998)](https://www.cs.duke.edu/~tomasi/papers/tomasi/tomasiIccv98.pdf)

* [Brown University CS129 Lecture 17: Recovering High Dynamic Range](http://cs.brown.edu/courses/csci1290/lectures/17.pdf)

* [Brown University CS129 Lecture 18: Tone Mapping](http://cs.brown.edu/courses/csci1290/lectures/18.pdf)

* [Fast Bilateral Filtering for HDR Display (Durand, SIGGRAPH 2002)](http://people.csail.mit.edu/fredo/PUBLI/Siggraph2002/DurandBilateral.pdf)

* [Gradient Domain High Dynamic Range Compression (Fattal, SIGGRAPH 2002)](http://www.cs.huji.ac.il/~danix/hdr/hdrc.pdf)

* [Photographic Tone Reproduction for Digital Images (Reinhard, SIGGRAPH 2002)](http://www.cs.utah.edu/~reinhard/cdrom/tonemap.pdf)

* [Recovering High Dynamic Range Radiance Maps from Photographs (Debevec, SIGGRAPH 1997)](http://www.pauldebevec.com/Research/HDR/debevec-siggraph97.pdf)

* [Stack Overflow: Formula to Determine Brightness of RGB Color](http://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color)

* [University of Edinburgh: Bilateral Filtering for Gray and Color Images](http://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/MANDUCHI1/Bilateral_Filtering.html)

* [Wikipedia: Relative Luminance](https://en.wikipedia.org/wiki/Relative_luminance)

## Miniatures

