---
title: "Linear Kernel: Why is it recommended for text classification ?"
date: "2014-10-19T19:42:11"
lastmod: "2020-07-26T14:48:31"
url: "/2014/10/svm-linear-kernel-good-text-classification/"
weight: 20
description: "A linear kernel is often recommended for text classification with SVM because text data has a lot of features and is often linearly separable."
---

The Support Vector Machine can be viewed as a kernel machine. As a result, you can change its behavior by using a different kernel function.

The most popular kernel functions are :

- the linear kernel
- the polynomial kernel
- the RBF (Gaussian) kernel
- the string kernel

## The linear kernel is often recommended for text classification

It is interesting to note that :

> The original optimal hyperplane algorithm proposed by Vapnik in 1963 was a [linear classifier](http://en.wikipedia.org/wiki/Linear_classifier "Linear classifier") [1]

That's only 30 years later that the [kernel trick](http://en.wikipedia.org/wiki/Kernel_trick "Kernel Trick article") was introduced.

If it is the simpler algorithm, **why is the linear kernel recommended for text classification**?

## Text is often linearly separable

Most of text classification problems are linearly separable [2]

![Linear kernel works well with linearly separable data](/wp-content/uploads/2014/07/linearlyVsNLinearly.png)

*Linear kernel works well with linearly separable data*

## Text has a lot of features

The linear kernel is good when there is **a lot of features**. That's because mapping the data to a higher dimensional space *does not really improve* the performance. [3]  In text classification, both the numbers of instances *(document)* and features *(words)* are large.

![linearKernlVsRbf](/wp-content/uploads/2014/07/linearKernlVsRbf.png)

As we can see in the image above, the decision boundary produced by a RBF kernel when the data is linearly separable is almost the same as the decision boundary produced by a linear kernel. Mapping data to a higher dimensional space using an RBF kernel was not useful.

## Linear kernel is faster

Training a SVM with a linear kernel is faster than with another kernel. Particularly when using a dedicated library such as [LibLinear](http://www.csie.ntu.edu.tw/~cjlin/liblinear/ "LibLinear hompage") [3]

## Less parameters to optimize

When you train a SVM with a linear kernel, you only need to optimize the C regularization parameter.  When training with other kernels, you also need to optimize the $\gamma$ parameter which means that performing a grid search will usually take more time.

## Conclusion

Linear kernel is indeed very well suited for text-categorization.

Keep in mind however that it is not the only solution and **in some case using another kernel might be better**.

The recommended approach for text classification is to **try a linear kernel first**, because of its advantages.  
If however you search to get the best possible classification performance, it might be interesting to try the other kernels to see if they help.

## References

[1]  [Support Vector Machines Article](http://en.wikipedia.org/wiki/Support_vector_machine "Wikipedia Support vector machine")[2] [Text Categorization with Support Vector Machines: Learning with Many Relevant Features](http://www.cs.cornell.edu/people/tj/publications/joachims_98a.pdf "Text Categorization with Support Vector Machines: Learning with Many Relevant Features ")[3] [A Practical Guide to Support Vector Classification](http://www.csie.ntu.edu.tw/~cjlin/papers/guide/guide.pdf "A Practical Guide to Support Vector Classification ")
