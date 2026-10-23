---
title: "How to prepare your data for text classification ?"
date: "2014-10-19T19:30:17"
lastmod: "2017-04-06T21:56:05"
url: "/text-classification-prepare-data/"
weight: 10
description: "For text classification, you often begin with some text you want to classify. But how should you prepare your data before giving it to an svm model?"
---

# Understand how data is represented

For text classification, you often begin with some text you want to classify. For instance, you have quotes and wants to find the quotes about love. Or you have emails and you want to separate spam from legitimate emails.

SVM is a **supervised-learning algorithm**. It means you will need to manually label some data with what you think is the correct choice. Then you train a SVM model with it. Eventually you can use it to predict unlabeled data.

In order to train a SVM model for text classification, you will need to **prepare your data** :

1. Label the data
2. Generate a vocabulary
3. Create a [document-term matrix](http://en.wikipedia.org/wiki/Document-term_matrix "Document term matrix definition").

If you don't have any data yet, you can download one of the available [datasets](http://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/ "LibSvm tools datasets") provided for free by the community.

However, you might be surprised by what you will find inside the files:

![lib svm dataset](/wp-content/uploads/2014/06/libsvm_dataset.png)

*Datasets are not very easy to read*

We want to classify *text*, but there is only *numbers* in this file!

### A (very) simple dataset for text classification

To understand better how data is represented, I will give you a simple example.  
We will try to classify some text about the weather using a support vector machine.

Our goal is to predict if the text is about a sunny or a rainy weather.  
To simplify more, **each sentence is written with these two words:  sunny or rainy.**

![Text classification : unlabeled data](/wp-content/uploads/2014/06/SVM_Tutorial_unlabeled_data.png "At first, we have unlabeled data")

For each line, we write

- **+1 if we think it should be classified as "sunny"**
- **-1 if we think it should be classified as "rainy".**

![Text classification : initial dataset](/wp-content/uploads/2014/06/SVM_Tutorial_initial_dataset.png "The initial labeled dataset")

Then we will look at each word in our dataset, and generate a **vocabulary**.

We just write each word in alphabetical order.

![Text classification : vocabulary](/wp-content/uploads/2014/06/SVM_Tutorial_vocabulary.png "That's a very simple vocabulary")

Eventually, for each sentence, we create a [document-term matrix](http://en.wikipedia.org/wiki/Document-term_matrix "Document term matrix definition").  
We begin the line with the class of the sentence (+1 or -1).  
Then we write the index of the word in our vocabulary. For the word sunny it is 2.  
We add a colon, and then the number of time the word appears in the sentence.

![Text classification: Document Term Matrix](/wp-content/uploads/2014/06/SVM_Tutorial_Document_Term_Matrix.png)

As you can see, we now have a dataset which looks like the example dataset found earlier.
