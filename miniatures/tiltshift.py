#!/usr/bin/python

from __future__ import division
import itertools, sys

import scipy.misc as imagelib
import scipy.ndimage as ndimage
from skimage import filter as skfilter
from skimage import color as skcolor
import numpy as np
from PIL import Image

from matplotlib import pyplot as plt

def saturate(im, amount=1.1):
  hsvim = skcolor.rgb2hsv(im)
  hue = np.take(hsvim, 0, axis=2)
  sat = np.take(hsvim, 1, axis=2)
  val = np.take(hsvim, 2, axis=2)
#   sat = sat * amount
  newhsv = np.dstack((hue, sat, val))
  return skcolor.hsv2rgb(newhsv)

def get_point(img):
  'Returns (x1, y1).'
  plt.imshow(img, cmap='gray')
  plt.title("Pick a point.")
  plt.xticks([])
  plt.yticks([])
  plt.draw()
  pts = map(lambda t: map(int, t), plt.ginput(1))[0]
  plt.close()
  return pts

def applyProgressiveGaussian(im, dof, filterLevel):
  #take the top dof pixels
  top, bottom = np.vsplit(im, [dof])
  #leave top, blur bottom
  newbot = skfilter.gaussian_filter(bottom, filterLevel)
  if (newbot.shape[0] > dof*2):
    newbot = applyProgressiveGaussian(newbot, dof, filterLevel*1.1)
  return np.vstack((top, newbot))

def minify(im, point, dof):
  #focus line is horizontal
  top, bottom = np.vsplit(im, [focusLinePoint[1]])
  top = np.flipud(applyProgressiveGaussian(np.flipud(top), dof, 1))
  bottom = applyProgressiveGaussian(bottom, dof, 1)
  return np.vstack((top, bottom))
  
if (len(sys.argv) != 3):
  print 'Usage: python tiltshift.py <image_name> <DOF in pixels>'

args = sys.argv[1:]
imname = args[0]
dof = int(args[1])
fullim = imagelib.imread(imname)

if (fullim.ndim == 3):
  b = np.float64(np.take(fullim, 0, axis=2))
  g = np.float64(np.take(fullim, 1, axis=2))
  r = np.float64(np.take(fullim, 2, axis=2))
  focusLinePoint = get_point(b)
  b_out = minify(b, focusLinePoint, dof)
  g_out = minify(g, focusLinePoint, dof)
  r_out = minify(r, focusLinePoint, dof)
  out = np.dstack((b_out, g_out, r_out))

out = saturate(out, amount=1.2)

outname = imname.split('.')[0] + '_out.jpg'
imagelib.imsave(outname, out)
Image.fromarray(np.uint8(out)).show()
