# NibEmbeddingView #

NibEmbeddingView is a simple class which provides a straightforward mechanism for embedding a view loaded from a nib into a view hierarchy, which could be generated in code, or in Interface Builder.

## Usage ##

To add to your app, simply copy the `NibEmbeddingView.h` and `NibEmbeddingView.m` files into your own project.

### Interface Builder Usage ###
1. Drag a plain view into your view hierarchy
2. Use the Identity Inspector to change the view's class to `NibEmbeddingView`
3. Add User Defined Runtime Attributes: `nibName` with the name of the nib to embed and, optionally, `nibBundleIdentifier` if the nib isn't located in the main bundle.
4. Add an outlet for the `NibEmbeddingView` and then access the embedded view using the `embeddedView` property.

![Configuring the View](Docs/identity_inspector.png?raw=true)

### Programmatic Usage ###

The view can also be used programmatically:

```Objective-C
NibEmbeddingView *view = [[NibEmbeddingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
[view embedViewFromNibName:@"MyView" bundle:nil];
MyView *embeddedView = view.embeddedView;
```


## Sample App ##

Check out `Main.storyboard` and `ViewController.m` for examples of how this can be used standalone, and inside of a collection view cell. Note in particular:

* If the embedded view has a variable size due to dynamic content, set up constraints such that the embedded container has a fixed margin around its content (see `SampleEmbeddedView.xib`). Configure a `NibEmbeddingView` to embed this, then give the embedding view a placeholder instrinsic size, but do not pin its width and height. After doing this, the embedding view will grow/shrink to wrap the content in the embedded view. (See the view in the bottom-right corner of `Main.storyboard`.)
* `ViewController.m` illustrates one approach to dealing with cells with dynamic sizes, although this is not specific to the use of the `NibEmbeddingView`.
