## 前言
　　本篇会简明扼要的介绍一下React的使用方法。代码会用JSX+ES5和JSX+ES6两种方式实现。　　
## React简介　　
　　React来自Facebook，于2013年开源。至今不断修改完善，现在已经到达了版本0.14.2。可以注意到版本还没有到1.0, 普遍应用到大部分产品中还需要一定的时间。2015年3月份，FaceBook发布了React Native，一个用react来构建native app的框架。
　　步入正题，React是一个javascript的类库，用于构建用户界面。
### 三个特点
* JUST THE UI
　　不同于Angularjs框架，React不属于MVC框架，它可以算是MVC里面的V层，所以相对来说入门也简单一下（只指入门，深度研究的话也不简单）。

* VIRTUAL DOM——虚拟DOM
　　虚拟dom其实是轻量的js对象，只保留了原生dom的一些常用的属性和方法。
	* 自定义标签
	　　学习React需要有一种全新的思路去看待view层的构建。除了使用html原生的标签，开发者还可以自定义标签（即虚拟DOM，最终给浏览器渲染的时候会解析成原生dom），自然代码解耦的效果会很明显，也更易读。
	* 性能提升
	　　在大家优化代码性能的时候，一定会关注有没有多余的dom操作，这是因为dom相关的操作耗时比较长。就算是创建一个空标签，也许要初始化它的各种默认属性和事件。
	　　React渲染页面并不直接操作dom，而是先通过[diff算法](http://www.laolifactory.com/index.php/2015/10/19/reacts-diff-algorithm-chinese/)比较前后虚拟dom的差异。这最大程度的简化dom操作，大大提高了性能。由于只是局部更新dom，所以只是局部刷新。
	　　换而言之，虚拟dom的出现，是因为目前js的性能比DOM渲染的性能要好，所以可以用更多的js操作换取更少的dom操作。也不排除如果将来有一天dom的性能和js差不多的时候，虚拟dom也许就没那么大的意义了。

* DATA FLOW
	React是单向响应的数据流。

## React相关知识简介
### jsx
　　一种特殊的js语法，可以在js代码中直接使用html标签。是个语法糖，提高编写代码效率。
　　要注意不能在标签的中间添加注释，因为最终还是要翻译成原生js，标签中添加注释相当于在一行代码还没完的时候就添加注释。
　　在jsx中，变量用花括号包围起来，花括号内的语句将以js代码的方式解析。
　　例如：
```
// 用纯js在react中创建a标签
var newDom=react.createelement('a', {
    href:="" 'https:="" facebook.github.io="" react="" '
},="" 'hello!');=""
```="" 用jsx在react中创建a标签="" var="" newdom="<a" href="https://facebook.github.io/react/">Hello!;
```

　　要让浏览器认识这种新的语法，就需要下面介绍的babel了。

### babel
　　　是一个javascript代码转换器，在这里我们可以用于jsx转换为原生js，es6转换为es5(大部分都能转换)。当然它的功能不只这些，有兴趣的可以去[babel官网](https://babeljs.io/)看看。它还有个[线上的转换器](https://babeljs.io/repl/)，代码比较简单的时候用这个排查问题或练习es6很方便。
　　介绍两种常用的使用方式：

* 一种是浏览器来编译，因为实时编译会很慢，所以适合代码量比较小的。只需在html中引用：

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.min.js"></script>
```

* 一种是本地使用。通过npm安装，在webpack中配置：

```
//在webpack.config.js文件中配置
module.exports = {
module: {
    loaders: [{
        test: /\.jsx?$/,
        loader: 'babel'
    }]
}
}
```
　　可以在本地编译好代码后，再将编译后的代码给html引用，提高性能，适合大项目。


### webpack
　　一个模块打包工具，它把不同的、相互依赖的静态资源都视作模块，并且打包成我们想要的静态资源。
　　另外可以方便的配置多种预处理器，如babel。
　　使用webpack，让代码组织更清晰，一个文件就是一个模块。

### ES6
　　ES6，也叫ECMAScript2015（以下统称ES6），是ECMAScript标准的最新版本。详细可见[ES6的特性简述（译+部分解析）](http://www.atatech.org/articles/44041)

## 搭建简单的运行环境
* 方式一：直接引入react、reactdom、babel的库。
　　因为这种方式是浏览器负责即时编译的，所以可想而知项目大了得时候解析速度会很慢，不建议使用。但是我们只是学习react语法嘛，当然要搭的环境越简单越好。
　　这种方式就是官网给出的实例所使用的方式。注意写jsx的的js块的type="text/babel",这样才能被浏览器识别并用babel编译。
　　以下是本章要用到的代码框架(一个helloword的demo) :

```html



   <meta charset="utf-8">
   <title>demo</title>


   <div id="example"></div>
   <script src="./build/react.js"></script>
   <script src="./build/react-dom.js"></script>
   <script src="./build/browser.min.js"></script>
   <script type="text/babel">
     // react代码写到这里
     ReactDOM.render(<h1>hello word!</h1>,document.getElementById('example'));
   </script>


```

* 方式二：使用npm + webpack
　　篇幅限制，下篇说，欢迎看第二篇。

## 学会react的基本语法
　　一般从定义到使用组件的流程是：定义组件creatClass,实现render方法-&gt;将组件渲染到页面ReactDOM.render()。
### 创建ReactElement
　　ReactElement对象可以看成是虚拟DOM树。它既是渲染组件ReactDOM.render(root,container)的第一个参数，又是创建组件React.createClass中render方法的返回值。记住ReactElement是唯一父节点的’dom树‘就好。

* react原生实现

```
React.createElement(
 string/ReactClass type, //type组件类型可以是内置的标签，如div；也可以是由React.createClass(object specification)创建的虚拟组件
 [object props], // 标签属性,数组
 [children ...],// 标签的innerHtml
)//返回类型是ReactElement
```

```
var newDom=React.createElement('a', {href: 'https://facebook.github.io/react/'}, 'Hello!');
```

* jsx实现

```
<a href="">Hello</a>
```

### 把组件渲染到浏览器中
　　react-dom模块中的方法。
　　`ReactDom.render(root, container);` root为ReactElement类型，表示root替换container中的元素。注意是替换不是追加，所以有些情况父元素应该设置为空。

* react原生

```
var content=React.createElement('h1',{},'hello');
ReactDOM.render(content,document.getElementById('example'));
```

* jsx

```
ReactDOM.render(<h1>hello word!</h1>,document.getElementById('example'));
```

### 创建组件
　　组件是一个自定义的js对象，在es5中使用React.createClass();在es6中必须继承React.component。
　　其中有个特殊的render方法，返回ReactElement对象。该方法会在我们使用JSX语法的标签<myelement>时被调用，因此我们在渲染组件时第一个参数可以使用<myelement>自定义标签或者createElement。
　　如：`ReactDOM.render(<myelement>,document.getElementById('example'))`  　　   　
* es5

```
var NewDom = React.createClass({//类名一定要大写开头
   render: function() {
       return (
           <ol>
             {
               React.Children.map(this.props.children, function (child) {
                 //获得元素的子元素
                 console.info(this);
                 console.info('child:'+child);
                 return <li>{child}</li>;//变量用花括号标识
               })//因为有多个子元素，所以返回的是数组。按照JSX变量是数组来解析。
             }
           </ol>
      );
   }
});
ReactDOM.render(
   <newdom>
       <span>lala</span>
       <span>ass</span>
   </newdom>,
    document.getElementById('example')
);
```
* es6

```
class NewDom extends React.Component{
   render() {//开头花括号一定要和小括号隔一个空格，否则识别不出来
       return <ol>//标签开头一定要和return一行
         {
            React.Children.map(this.props.children, function (child) {
                  return <li>{child}</li>;
            })
         }
       </ol>;
   }
}
ReactDOM.render(
   <newdom>
       <span>lala</span>
       <span>ass</span>
   </newdom>,
    document.getElementById('example')
);
```
###  组件的属性props
一个js对象，对应于dom的属性。
* 原生属性
某些html的属性名因为正好是js得保留字，所以需要重新命名。
* class
   因为js中class为保留字，所以要写成className。
   `<a classname="center"></a>`
* style
style属性接受由css属性构成的js对象。对于jsx来说第一是变量，第二是对象，因此要两个花括号，key值用驼峰命名法转化了，value值用引号括起来
`<a style="{{backgroundImage:" 'url('="" +="" imgurl="" ')',font:'12px'}}=""></a>`
* 新增属性
 this.props.children  表示组件的所有子节点，上一小节的示范代码中有介绍
* 传递属性值
 在ReactDOM.Render第一个参数中直接写入带属性的标签即可： `<a newprop="propValue"></a>` 。这样就可以在this.props['newProp']中读取值
* 设置默认属性
 * 在ES6中为属性：defaultProps(可以标识static定义在class内，也可以定义在class外)
 * 在ES5中为方法：getDefaultProps: function(){return {name:value}};
* 属性的读取
   this.props['propName']获得属性
* 新增功能：属性校验器propTypes
见代码示例
* 代码示范
 * es5

```
var NewDom = React.createClass({//类名一定要大写开头
   getDefaultProps: function() {//设置默认属性
      return {title:'133'};
   },
   propTypes: {
      title:React.PropTypes.string,
   },//属性校验器，表示必须是string
   render: function() {
      return <div>{this.props.title}</div>;//变量用花括号标识
   }
});
```

 * es6

```
class NewDom extends React.Component{
 //不能再组件定义的时候定义一个属性
 render() {
     return <div>1{this.props.title}</div>;
 }//开头花括号一定要和小括号隔一个空格，否则识别不出来
}
//es6 这两个属性不能写在class内。
NewDom.propTypes={//属性校验器，表示改属性必须是bool，否则报错
 title: React.PropTypes.bool,
}
NewDom.defaultProps={title:'133'};//设置默认属性
```

### 组件的状态state
　　一个js对象，存储着组件当前的状态以及其值的集合。
　　个人觉得这也是react的创新点之一，可以把组件看成一个“状态机”. 根据不同的status有不同的UI展示。只要使用setState改变状态值，根据diff算法算出来有差以后，就会执行ReactDom的render方法，重新渲染页面。
　　这避免了开发者直接操作dom对象已达到重新渲染页面。开发者只需要关注state这个中间人，控制它就可以控制页面刷新。第二篇中评论框的渲染就是使用的state来控制。
　　是不是感觉和props有些类似？一般区分两个的原则是，可变的放在state中，不可变的放在props中。　

* 初始化
* es5

```
class *** extends React.Component{
 getInitialState: function() {
   return {liked: false};
 }
}
```

* es6

```
class *** extends React.Component{
  constructor(props) {
   super(props);
   this.state = {liked: false};
 }
}
```
* 修改值
 es5和es6中使用方法相同。
 `this.setState(新的state对象);`
* 读取值
其实就是读取一个js对象。

### 事件
* 事件名
和属性名类似，到了react中，事件名也成了驼峰命名法，比如onclick变为了onClick.

* 事件定义
一定要注意es6中元素如何使用自定义事件。见代码。
* es5

```
var NewDom = React.createClass({//类名一定要大写开头
   btnClick:function(ele){
      console.info(ele);
      console.info(this.refs.tex);
   },
   render: function() {
      return <div>
         <input type="text" ref="tex">
         <input type="button" onclick="{this.btnClick}" value="click me">
      </div>;//变量用花括号标识
   }
});
```

 * es6

```
class NewDom extends React.Component{
   btnClick(){
       console.info(this);//this为该组件类
       console.info(this.refs.tex);//this.refs.tex为组件里面索引为tex的
   }
   render() {
       return <div>
           <input type="text" ref="tex">
           <input type="button" onclick="{this.btnClick.bind(this)}" value="click me">
       </div>;//注意bind后面的this
   }
}
```

* 事件target
下面是一个事件对应要执行的函数的定义：

```
handleChange: function(event) {
   this.setState({value: event.target.value});//event.target.value元素的值
 }
```

每个控件取值不一样，value是指input控件，下拉框为selected，radiobutton为checked。a标签是innerHtml。可以自己通过console.info(e.target)  调试出自己想要的那个字段


## ES6的坑
* 类名(组件名)一定要用大写开头，否则自定义的组件无法编译，识别不出来。
* 类中定义render函数要注意两点，见代码注释。

```
render() {//开头花括号一定要和小括号隔一个空格，否则识别不出来
  return <ol>//标签前一半一定要和return一行
    {
       React.Children.map(this.props.children, function (child) {
          return <li>{child}</li>;
       })
     }
  </ol>;
}
```

* 在class中使用class的变量或者方法，一定要加个this。如this.handlerclick。
* es6 绑定事件需要`onClick={this.func1.bind(this)}`。
这样func1和bind里面的参数‘this’的作用域才绑定到了一起（注意es5是不需要这个bind(this)的），func1中如果有this.name这类语句，相当于是使用参数‘this’里面的变量值;或者使用箭头函数func1= (e)=&gt; {函数体}

## 小结
　　经过这番简单的练习后，如果还想看看做一个项目中如何使用react参见下章，一个模仿微博展示的demo（编写ing）。
　　本文没有对react作深入的研究。通过学习react的使用方法可以看到，react入门的话相对于其他框架还是比较简单的，代码逻辑也很清晰，好维护也好使用。重要的是，需要使用者把从前直接对dom操作的思维方式转换过来，相信会爱上它的。
　　ps: react 还在发展期，学习的话建议英语好的直接看官方文档，可以少走一些弯路。</myelement></myelement></myelement></react.createelement('a',>