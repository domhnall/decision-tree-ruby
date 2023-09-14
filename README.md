# Machine Learning Using Decision Trees in Ruby

This small repo is intended to act as a demonstration of how we can 
use the CART algorithm (Classification and Regression Trees) to build a
decision tree model in ruby.

The example data is whimsical, but the fundamentals of the algorithm
are sound.

To train the model on the sample data run

> ruby runner.rb

If you want to train the model on the (mushroom dataset)[https://archive.ics.uci.edu/dataset/73/mushroom]:

> ruby runner.rb mushroom

In both cases the model will hold out 10% of the data for
testing/evaluation.


Please refer to the [blog
article](https://www.vector-logic.com/blog/posts/machine-learning-using-decision-trees-in-ruby)
for a more detailed discussion of how this decision tree model is
implemented.
