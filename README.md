Transfer learning to count calories
===================================

Steps:
------

1. Data: [UECFOOD-100] or [UECFOOD-256] from Kawano and Yanai 2014.
Might be cooler to do the latter (256 kinds, 4x as much data)

2. Load the pre-trained VGG16 network (from Simonyan and Zisserman 2014)

  * The configuration is available in the dl4j [model zoo] (VGGNetD).
  * [Import][importing Keras models] the model weights from [here][VGG16 model for Keras] (in Keras format)

3. Chop off last 1-2 layers (softmax classification layer and perhaps one additional one)

4. Train another network on top of the resulting one in predicting the classes from our dataset:

  * https://blog.keras.io/building-powerful-image-classification-models-using-very-little-data.html



[UECFOOD-100]: http://foodcam.mobi/dataset100.html
[UECFOOD-256]: http://foodcam.mobi/dataset256.html
[VGG16 model for Keras]: https://gist.github.com/baraldilorenzo/07d7802847aaad0a35d3
[importing Keras model]: https://deeplearning4j.org/model-import-keras
[model zoo]: https://deeplearning4j.org/model-zoo


