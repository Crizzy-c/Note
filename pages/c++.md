# 一些小常识

#### std命名空间

**using namespace std;**  的作用相当于   **std::(+语句)**

#### ios::

如果有**#include< iostream>**可以不写

###### string类

std空间内含有string类

# 一些语句表达

```c++
val=1e10+1; 
```

将val初始化为    1x10^10^+1  

# 特殊语句

### 强制类型转换符

```c++
(double) a;  //将a从int类型转换为double类型
(int)(x+y);  //将x+y的值转换为int类型
```

### 声明

###### #define

###### const （类型名） （变量名）

定义某个变量为常量，初始化赋值

###### typedef

```c
typedef int Integer;  //指定用Integer作为类型名，作用与int相同
```

# STL   -      C++标准模板库

STL 使用了**很多复杂的结构**来实现**丰富的功能**，它的效率往往是比不上自己手搓针对特定题目的数据结构与算法的。因此，STL 的使用相当于使用**更长的运行时间**换取**更高的编程效率**。因此，在实际比赛中要权衡 STL 的利弊。

###### 四个组件

## 算法（Algorithms)

##### 内容总览

打勾的是本次将会详细讲解的，其他的是算法竞赛中建议学习的，不在下表列出的在比赛中基本用不到。

（很多函数的功能很简单，自己都能快速写出来，但是使用函数可以让代码可读性变得更高，这在比赛中是至关紧要的）



- 算法库 Algorithm
	-  `count()`
	-  `find()`
	-  `fill()`
	-  [`swap()`](https://zh.cppreference.com/w/cpp/algorithm/swap)
	-  [`reverse()`](https://zh.cppreference.com/w/cpp/algorithm/reverse)
	-  `shuffle()` C++11
	-  [`unique()`](https://zh.cppreference.com/w/cpp/algorithm/unique)
	-  [`sort()`](https://zh.cppreference.com/w/cpp/algorithm/sort)
	-  [`lower_bound()`](https://zh.cppreference.com/w/cpp/algorithm/lower_bound) / [`upper_bound()`](https://zh.cppreference.com/w/cpp/algorithm/upper_bound)
	-  [`max()`](https://zh.cppreference.com/w/cpp/algorithm/max) / [`min()`](https://zh.cppreference.com/w/cpp/algorithm/min)
	-  `max_element()` / `min_element()`
	-  `prev_permutation()` / `next_permutation()`
- 数学函数 cmath
	-  [`abs()`](https://zh.cppreference.com/w/cpp/numeric/math/fabs)
	-  [`exp()`](https://zh.cppreference.com/w/cpp/numeric/math/exp)
	-  [`log()`](https://zh.cppreference.com/w/cpp/numeric/math/log) / `log10()` / `log2()`
	-  [`pow()`](https://zh.cppreference.com/w/cpp/numeric/math/pow)
	-  [`sqrt()`](https://zh.cppreference.com/w/cpp/numeric/math/sqrt)
	-  `sin()` / `cos()` / `tan()`
	-  `asin()` / `acos()` / `atan()`
	-  `sinh()` / `cosh()` / `tanh()`
	-  `asinh()` / `acosh()` / `atanh()` C++11
	-  [`ceil()`](https://zh.cppreference.com/w/cpp/numeric/math/ceil) / [`floor()`](https://zh.cppreference.com/w/cpp/numeric/math/floor)
	-  [`round()`](https://zh.cppreference.com/w/cpp/numeric/math/round) C++11
- 数值算法 numeric
	-  `iota()` C++11
	-  `accumulate()`
	-  [`gcd()`](https://zh.cppreference.com/w/cpp/numeric/gcd) C++17
	-  [`lcm()`](https://zh.cppreference.com/w/cpp/numeric/lcm) C++17
- 伪随机数生成 random
	-  `mt19937`
	-  `random_device()`

#### `swap()`

交换两个变量的值

**用法示例**

```
template< class T >
void swap( T& a, T& b );
```

```
int a = 0, b = 1;
swap(a, b);
// now a = 1, b = 0

int arr[10] {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
swap(arr[4], arr[6]);
// now arr = {0, 1, 2, 3, 6, 5, 4, 7, 8, 9}
```

**注意事项**

这个 swap 参数是引用的，不需要像 C 语言一样取地址。

#### `sort()`

使用快速排序给一个可迭代对象排序

**用法示例**

```c++
template< class RandomIt, class Compare >
void sort( RandomIt first, RandomIt last, Compare comp );
```

默认排序从小到大

```c++
vector<int> arr{1, 9, 1, 9, 8, 1, 0};
sort(arr.begin(), arr.end());
// arr = [0, 1, 1, 1, 8, 9, 9]
```

如果要从大到小，则需要传比较器进去。

```
vector<int> arr{1, 9, 1, 9, 8, 1, 0};
sort(arr.begin(), arr.end(), greater<int>());
// arr = [9, 9, 8, 1, 1, 1, 0]
```

如果需要完成特殊比较，则需要手写比较器。

比较器函数返回值是 bool 类型，传参是需要比较的两个元素。记我们定义的该比较操作为 ⋆：

- 若 a ⋆ b，则比较器函数应当返回 `true`
- 若 a ⋆̸ b，则比较器函数应当返回 `false`

**注意：**如果 a = b，比较器函数必须返回 `false`

```
bool cmp(pair<int, int> a, pair<int, int> b)
{
    if (a.second != b.second)
        return a.second < b.second;
    return a.first > b.first;
}

int main()
{
    vector<pair<int, int>> arr{{1, 9}, {2, 9}, {8, 1}, {0, 0}};
	sort(arr.begin(), arr.end(), cmp);
    // arr = [(0, 0), (8, 1), (2, 9), (1, 9)]
}
```

#### lower_bound()

在**已升序排序**的元素中，应用二分查找检索指定元素，返回对应元素迭代器位置。**找不到则返回尾迭代器。**

- `lower_bound()`: 寻找 ≥ x 的第一个元素的位置
- `upper_bound()`: 寻找 > x 的第一个元素的位置

怎么找 ≤ x / < x 的第一个元素呢？

- \> x 的第一个元素的前一个元素（如果有）便是 ≤ x 的第一个元素
- ≥ x 的第一个元素的前一个元素（如果有）便是 < x 的第一个元素

返回的是迭代器，如何转成下标索引呢？减去头迭代器即可。

**用法示例**

```
template< class ForwardIt, class T >
ForwardIt lower_bound( ForwardIt first, ForwardIt last, const T& value );
```

```
vector<int> arr{0, 1, 1, 1, 8, 9, 9};
vector<int>::iterator it = lower_bound(arr.begin(), arr.end(), 7);
int idx = it - arr.begin();
// idx = 4
```

我们通常写成一行：

```
vector<int> arr{0, 1, 1, 1, 8, 9, 9};
idx = lower_bound(arr.begin(), arr.end(), 7) - arr.begin(); // 4
idx = lower_bound(arr.begin(), arr.end(), 8) - arr.begin(); // 4
idx = upper_bound(arr.begin(), arr.end(), 7) - arr.begin(); // 4
idx = upper_bound(arr.begin(), arr.end(), 8) - arr.begin(); // 5
```

#### reverse()

反转一个可迭代对象的元素顺序

**用法示例**

```
template< class BidirIt >
void reverse( BidirIt first, BidirIt last );
```

```
vector<int> arr(10);
iota(arr.begin(), arr.end(), 1);
// 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
reverse(arr.begin(), arr.end());
// 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
```

#### `max()` / `min()`

返回最大值 / 最小值的**数值**

**用法示例**

```
int mx = max(1, 2); // 2
int mn = min(1, 2); // 1
```

在 C++11 之后，可以使用列表构造语法传入一个列表，这样就能一次性给多个元素找最大值而不用套娃了：

```
// Before C++11
int mx = max(max(1, 2), max(3, 4)); // 4
int mn = min(min(1, 2), min(3, 4)); // 1

// After C++11
int mx = max({1, 2, 3, 4}); // 4
int mn = min({1, 2, 3, 4}); // 1
```

#### `unique()`

消除数组的重复**相邻**元素，数组长度不变，但是有效数据缩短，返回的是有效数据位置的结尾迭代器。

例如：$[1,1,4,5,1,4]\to[1,4,5,1,4,\underline?]$，下划线位置为返回的迭代器指向。

```
template< class ForwardIt >
ForwardIt unique( ForwardIt first, ForwardIt last );
```

**用法示例**

单独使用 unique 并不能达成去重效果，因为它只消除**相邻**的重复元素。但是如果序列有序，那么它就能去重了。

但是它去重后，序列尾部会产生一些无效数据：$[1,1,2,4,4,4,5]\to[1,2,4,5,\underline?,?,?]$，为了删掉这些无效数据，我们需要结合 erase.

最终，给 vector 去重的写法便是：

```
vector<int> arr{1, 2, 1, 4, 5, 4, 4};
sort(arr.begin(), arr.end());
arr.erase(unique(arr.begin(), arr.end()), arr.end());
```

#### 数学函数

所有函数参数均支持 `int` / `long long` / `float` / `double` / `long double`

公式示例f ( x ) = | x |`abs(-1.0)`f ( x ) = e x`exp(2)`f ( x ) = ln ⁡ x`log(3)`f ( x , y ) = x y`pow(2, 3)`f ( x ) = x`sqrt(2)`f ( x ) = ⌈ x ⌉`ceil(2.1)`f ( x ) = ⌊ x ⌋`floor(2.1)`f ( x ) = ⟨ x ⟩`rount(2.1)`

**注意事项**

由于浮点误差，有些的数学函数的行为可能与预期不符，导致 WA。如果你的操作数都是整型，那么用下面的写法会更稳妥。

> 原文地址：https://codeforces.com/blog/entry/107717

- ⌊ a b ⌋
	- 别用：`floor(1.0 * a / b)`
	- 要用：`a / b`
- ⌈ a b ⌉
	- 别用：`ceil(1.0 * a / b)`
	- 要用：`(a + b - 1) / b` （$\lceil\frac{a}{b}\rceil=\lfloor\frac{a+b-1}{b}\rfloor$）
- ⌊ a ⌋
	- 别用：`(int) sqrt(a)`
	- 要用：二分查找 https://io.zouht.com/7.html
- a b
	- 别用：`pow(a, b)`
	- 要用：快速幂 https://io.zouht.com/18.html
- ⌊ log 2 ⁡ a ⌋
	- 别用：`log2(a)`
	- 要用：`__lg` （不规范，但是这是竞赛）/ `bit_width`（C++20 可用）

####  `gcd()` / `lcm()`

（C++17）返回最大公因数 / 最小公倍数

```
int x = gcd(8, 12); // 4
int y = lcm(8, 12); // 24
```

如果不是 C++17，但是是 GNU 编译器（g++），那么可以用内置函数 `__gcd()`.

当然，`gcd` / `lcm` 函数也挺好写，直接写也行（欧几里得算法）：

```
int gcd(int a, int b)
{
    if (!b)
        return a;
    return gcd(b, a % b);
}

int lcm(int a, int b)
{
    return a / gcd(a, b) * b;
}
```

## 容器（Containers）

```
priority_queue<int> pque
```

###### 常用容器

*加粗是有必要学习的

- 顺序容器
	-  **array**
	-  **vector**
	-  **deque**
	-  forward_list
	-  **list**
- 关联容器
	-  **set**
	-  **map**
	-  **multiset**
	-  **multimap**
- 无序关联容器
	-  **unordered_set**
	-  **unordered_map**
	-  **unordered_multiset**
	-  **unordered_multimap**
- 容器适配器
	-  **stack**
	-  **queue**
	-  **priority_queue**
	-  flat_set
	-  flat_map
	-  flat_multiset
	-  flat_multimap
- 字符串
	-  **string** (basic_string<char>)
- 对与元组
	-  **pair**
	-  **tuple**

### Vector  向量

连续的顺序的储存结构（和数组一样的类别），但是有长度可变的特性。

vector的数据存储在堆空间里所以不会栈溢出（爆栈）。

#include< vector >

###### (1) 时间复杂度：

$O(n)$

###### (2) 创建vector对象:

**一维**

vector<int> array;

`vector<类型> arr(长度, [初值])`

vector< int >  arr(100,1);    //构造初始长100的int数组，初值为1

vector<int> ans={-1,-1};

**二维**

```c++
vector<vector<int>> mat(100, vector<int> ()); 
// 构造初始100行，不指定列数的二维数组
vector<vector<int>> mat(100, vector<int> (666, -1)) 
// 构造初始100行，初始666列的二维数组，初值为-1
```

==将数据动态读入二维数组中==

```c++
	vector<vector<int>> matrix;
    int rows;//二维动态数组的行数
    cin >> rows;

    // 逐行输入数据
    for (int i = 0; i < rows; i++) 
    {
        vector<int> row;
        int num;
        row.push_back(num);
        matrix.push_back(row);
    }
```

**三维**

```c++
vector< vector< vector<int> > > arr(5,vector< vector<int> >(6,vector<int>(4)));//等价于  int arr[5][6][4];
```

一些小奇葩

```c++
vector<int> arr[100];         
// 正确，构造初始100行，不指定列数的二维数组，可用于链式前向星存图
vector<int> arr[100](100, 1); // 语法错误！
vector<int> arr(100, 1)[100]; // 语法错误！
vector<int> arr[100] {{100, 1}, 这里省略98个 ,{100, 1}}; // 正确但奇葩，使用列表初始化
```

**==！动态扩展行数和列数！==**

 1. 动态扩展行数（添加新行）

直接使用 `push_back` 添加新行：

```c++
vector<vector<int>> arr;  // 空的二维数组

// 添加一行（列数可以随意）
arr.push_back({1, 2, 3});           // 第0行: 3列
arr.push_back({4, 5});               // 第1行: 2列
arr.push_back(vector<int>(4, 0));    // 第2行: 4列（全0）
```

------

2. 动态扩展列数（修改某行的列数）

用 `resize` 调整某一行的列数：

```c++
// 扩展第1行的列数（从2列→5列，多的补0）
arr[1].resize(5);  

// 缩减第0行的列数（从3列→2列，多的丢弃）
arr[0].resize(2);  
```

###### (3) 向量尾部插入/删除元素

array.emplace_back(a);//尾部插入数字a

array.push_back(a); //尾部插入数字a

- `push_back`：先在队伍外面做好一杯奶茶（创建对象），再复制到队伍末尾。
- `emplace_back`：直接在队伍末尾现场做一杯奶茶（构造对象），**省去复制过程，更高效**。

array.pop_back(); //删除向量的最后一个元素

###### (4) 使用下标访问元素:

array[0],array[1]......array[n]
array.at(i) //使用at(),当这个函数越界时会抛出一个异常

###### (5) 使用迭代器访问元素:

vector<int>::iterator it;
for(it=array.begin();it!=array.end();it++)
    cout<<*it<<endl;

###### (6) 插入元素：

array.insert(array.begin()+i,a); //在第i+1个元素前面插入a;

###### (7) 删除元素：

array.erase(array.begin()+2); //删除第3个元素,后面的数组下标会往前挪一位（数组长度-1)
array.erase(array.begin()+i,array.end()+j); //删除区间[i,j-1],区间从0开始

###### (8) 动态数组的长度（向量大小）:

 array.size();

###### (9) 清空:

 array.clear();

*清空所有数据并释放内存*

vector< int >().swap(array);

###### (10) 判空：

array.empty(); //当元素个数为0时返回true（即输出1），否则为false（即输出0）

###### (11) 返回最后一个元素：

array.back();

###### (12) 返回第一个元素：

array.front();

###### (13) 返回内存中总共可以容纳的元素个数：

array.capacity();

###### (14) 调整元素个数：

a.resize(10); //将a的现有元素个数调至10个，多则删，少则补，其值随机
a.resize(10,2); //将a的现有元素个数调至10个，多则删，少则补，其值为2

###### (15）扩充容量：

a.reserve(100); //将a的容量（capacity）扩充至100


###### (16）两向量交换：

a.swap(b); //将a中的元素和b中的元素进行整体性交换


###### (17）向量的比较：

向量的比较操作 == != >= <= > <  
a==b;

###### vector数组array的输入

int一个变量a，cin>>a,然后array.push_back(a);

重要说明：vector的元素不仅仅可以是int,double,string,还可以是结构体，但是要注意：结构体要定义为全局的，否则会出错。

#### 注意事项

##### 提前指定长度

如果长度已经确定，那么应当直接在构造函数指定长度，而不是一个一个 `.push_back()`. 因为 `vector` 额外内存耗尽后的重分配是有时间开销的，直接指定长度就不会出现重分配了。

```c++
// 优化前: 522ms
vector<int> a;
for (int i = 0; i < 1e8; i++)
    a.push_back(i);
// 优化后: 259ms
vector<int> a(1e8);
for (int i = 0; i < a.size(); i++)
    a[i] = i;
```

##### 当心 size_t 溢出

vector 获取长度的方法 `.size()` 返回值类型为 `size_t`，通常 OJ 平台使用的是 32 位编译器（有些平台例如 cf 可选 64 位），那么该类型范围为 [ 0 , 2 32 ).

```c++
vector<int> a(65536);
long long a = a.size() * a.size(); // 直接溢出变成0了
```

### Stack   栈

**`#include <stack>`**

通过二次封装双端队列 (deque) 容器，实现先进后出的栈数据结构。

#### 常用方法

| 作用   | 用法              | 示例                 |
| ------ | ----------------- | -------------------- |
| 构造   | `stack<类型> stk` | `stack<int> stk;`    |
| 进栈   | `.push(元素)`     | `stk.push(1);`       |
| 出栈   | `.pop()`          | `stk.pop();`         |
| 取栈顶 | `.top()`          | `int a = stk.top();` |

查看大小 / 清空 / 判空：略

#### 适用情形

如果不卡常的话，就可以直接用它而不需要手写栈了。

另外，vector 也可以当栈用，vector 的 `.back()` 取尾部元素，就相当于取栈顶，`.push_back()` 相当于进栈，`.pop_back()` 相当于出栈。

#### 注意事项

不可访问内部元素！**下面都是错误用法**

```c++
for (int i = 0; i < stk.size(); i++)
    cout << stk[i] << endl;
for (auto ele : stk)
    cout << stk << endl;
```

### Queue 队列

通过二次封装双端队列 (deque) 容器，实现先进先出的队列数据结构。

**`#include <queue>`**

**用法**

| 作用                   | 用法              | 示例                   |
| ---------------------- | ----------------- | ---------------------- |
| 构造                   | `queue<类型> que` | `queue<int> que;`      |
| 进队                   | `.push(元素)`     | `que.push(1);`         |
| 出队                   | `.pop()`          | `que.pop();`           |
| 取队首                 | `.front()`        | `int a = que.front();` |
| 取队尾                 | `.back()`         | `int a = que.back();`  |
| 查看大小 / 清空 / 判空 | 略                | 略                     |

如果不卡常的话，就可以直接用它而不需要手写队列了。

不可访问内部元素！错误示例与栈相同

### priority_queue 优先队列

提供常数时间的最大元素查找，对数时间的插入与提取，底层原理是二叉堆。

**`#include <queue>`**

#### 构造

**`priority_queue<类型, 容器, 比较器> pque`**

- 类型：要储存的数据类型
- 容器：储存数据的底层容器，默认为 `vector<类型>`，竞赛中保持默认即可
- ==比较器：==比较大小使用的比较器，默认为 `less<类型>`，可自定义

```c++
priority_queue<int> pque1;                            // 储存int的大顶堆
priority_queue<int, vector<int>, greater<int>> pque2; // 储存int的小顶堆
```

> 对于需要自定义比较器的情况，涉及一些初学时容易看迷糊的语法（重载小括号运算符 / lambda 表达式），在此就不展开讲了。如果想要了解，可以查阅 cppreference 中的代码示例。

#### 其他

| 作用            | 用法                               | 示例                 |
| --------------- | ---------------------------------- | -------------------- |
| 进堆            | `.push(元素)` ==`.emplace(元素)`== | `que.push(1);`       |
| 出堆            | `.pop()`                           | `que.pop();`         |
| 取堆顶          | `.top()`                           | `int a = que.top();` |
| 查看大小 / 判空 | 略                                 | 略                   |

pq.empty()仅是判空（然后返回一个值）。不可以clear清空整个数组。还是要一个一个pop

进出队复杂度 O ( log ⁡ n )，取堆顶 O ( 1 ).

#### 适用情形

持续维护元素的有序性：每次向队列插入大小不定的元素，或者每次从队列里取出大小最小/最大的元素，元素数量 n，插入操作数量 k.

- 每次插入后进行快速排序：$k\cdot n\log n$
- 使用优先队列维护：$k\cdot\log n$

####  注意事项

##### 仅堆顶可读

只可访问堆顶，其他元素都无法读取到。**下面是错误用法：**

```c++
cout << pque[1] << endl;
```

##### 所有元素不可写

堆中所有元素是不可修改的。**下面是错误用法：**

```c++
pque[1] = 2;
pque.top() = 1;
```

如果你恰好要修改的是堆顶元素，那么是可以完成的：

```c++
int tp = pque.top();
pque.pop();//把堆顶的弹掉然后切换元素上去
pque.push(tp + 1);
```

### set      集合  

**`#include <set>`**

提供对数时间的插入、删除、查找的集合数据结构。底层原理是红黑树。

| 集合三要素 | 解释                           | set           | multiset      | unordered_set |
| ---------- | ------------------------------ | ------------- | ------------- | ------------- |
| 确定性     | 一个元素要么在集合中，要么不在 | ✔             | ✔             | ✔             |
| 互异性     | 一个元素仅可以在集合中出现一次 | ✔             | ❌（任意次）   | ✔             |
| 无序性     | 集合中的元素是没有顺序的       | ❌（从小到大） | ❌（从小到大） | ✔             |

**构造**

**`set<类型, 比较器> st`**

- 类型：要储存的数据类型
- 比较器：比较大小使用的比较器，默认为 `less<类型>`，可自定义

```c++
set<int> st1;               // 储存int的集合（从小到大）
set<int, greater<int>> st2; // 储存int的集合（从大到小）
```

> 对于需要自定义比较器的情况，涉及一些初学时容易看迷糊的语法（重载小括号运算符 / lambda 表达式），在此就不展开讲了。

**遍历** 

可使用迭代器进行遍历：

```c++
for (set<int>::iterator it = st.begin(); it != st.end(); ++it)
    cout << *it << endl;
```

基于范围的循环（C++ 11）：

```
for (auto &ele : st)
    cout << ele << endl;
```

#### 其他

| 作用                   | 用法            | 示例                    |
| ---------------------- | --------------- | ----------------------- |
| 插入元素               | `.insert(元素)` | `st.insert(1);`         |
| 删除元素               | `.erase(元素)`  | `st.erase(2);`          |
| 查找元素               | `.find(元素)`   | `auto it = st.find(1);` |
| 判断元素是否存在       | `.count(元素)`  | `st.count(3);`          |
| 查看大小 / 清空 / 判空 | 略              | 略                      |

增删查时间复杂度均为 O ( log ⁡ n )

####  适用情形

- 元素去重：$[1,1,3,2,4,4]\to[1,2,3,4]$
- 维护顺序：$[1,5,3,7,9]\to[1,3,5,7,9]$
- 元素是否出现过：元素大小 [ − 10 18 , 10 18 ]，元素数量 10 6，vis 数组无法实现，通过 set 可以完成。

####  注意事项

##### 不存在下标索引

set 虽说可遍历，但仅可使用迭代器进行遍历，它不存在下标这一概念，无法通过下标访问到数据。**下面是错误用法：**

```
cout << st[0] << endl;
```

##### 元素只读

set 的迭代器取到的元素是只读的（因为是 const 迭代器），不可修改其值。如果要改，需要先 erase 再 insert. **下面是错误用法：**

```
cout << *st.begin() << endl; // 正确。可读。
*st.begin() = 1;             // 错误！不可写！
```

不可用迭代器计算下标

set 的迭代器不能像 vector 一样相减得到下标。**下面是错误用法：**

```
auto it = st.find(2);      // 正确，返回2所在位置的迭代器。
int idx = it - st.begin(); // 错误！不可相减得到下标。
```

### map 映射

**`#include <map>`**

提供对数时间的有序键值对结构。底层原理是红黑树。

映射： $$ \begin{matrix} 1&\to&2\ 2&\to&2\ 3&\to&1\ 4&\to&5\ &\vdots \end{matrix} $$

| 性质   | 解释                         | map           | multimap      | unordered_map |
| ------ | ---------------------------- | ------------- | ------------- | ------------- |
| 互异性 | 一个键仅可以在映射中出现一次 | ✔             | ❌（任意次）   | ✔             |
| 无序性 | 键是没有顺序的               | ❌（从小到大） | ❌（从小到大） | ✔             |

#### 构造

**map< ==键类型, 值类型, 比较器==> mp**

- **==键类型==**：要储存键的数据类型
- **==值类型==**：要储存值的数据类型

*****    `std::map` 中的每个元素都是一个 `std::pair`，包含两个成员：

1. **`first`**：键（key），即元素的键值。
2. **`second`**：值（value），即与键关联的值。

例如，对于 `std::map<int, std::string>`，每个元素是一个 `std::pair<int, std::string>`，其中：

- `first` 是 `int` 类型的键。
- `second` 是 `std::string` 类型的值。

- **==比较器==**：键比较大小使用的比较器，默认为 `less<类型>`，可自定义

```
map<int, int> mp1;               // int->int 的映射（键从小到大）
map<int, int, greater<int>> st2; // int->int 的映射（键从大到小）
```

> 对于需要自定义比较器的情况，涉及一些初学时容易看迷糊的语法（重载小括号运算符 / lambda 表达式），在此就不展开讲了。

```c++
map<string,int>a;
a["awa"]=3;
a["bwb"]=2;
//string默认是字典序，即awa < bwb
```

#### 遍历

可使用迭代器进行遍历：

```c++
for (map<int, int>::iterator it = mp.begin(); it != mp.end(); ++it)
    cout << it->first << ' ' << it->second << endl;
    //     提取该元素的键         提取该元素的值
```

基于范围的循环（C++ 11）：

```
for (auto &pr : mp)
    cout << pr.first << ' ' << pr.second << endl;
```

结构化绑定 + 基于范围的循环（C++17）：

```
for (auto &[key, val] : mp)
    cout << key << ' ' << val << endl;
```

#### 其他

| 作用                   | 用法           | 示例                    |
| ---------------------- | -------------- | ----------------------- |
| 增 / 改 / 查元素       | 中括号         | `mp[1] = 2;`            |
| 查元素（返回迭代器）   | `.find(元素)`  | `auto it = mp.find(1);` |
| 删除元素               | `.erase(元素)` | `mp.erase(2);`          |
| 判断元素是否存在       | `.count(元素)` | `mp.count(3);`          |
| 查看大小 / 清空 / 判空 | 略             | 略                      |

增删改查时间复杂度均为 O ( log ⁡ n )

**返回尾部元素：                **  **mp.end()-1**

`end()` 返回的是尾后迭代器, 通过  **- - mp.end() ** 可以将迭代器移动到最后一个元素的位置。

**适用情形**

需要维护映射的场景可以使用：输入若干字符串，统计每种字符串的出现次数。(`map<string, int> mp`)

#### 注意事项

##### 中括号访问时默认值

如果使用中括号访问 map 时对应的键不存在，那么会新增这个键，并且值为默认值，因此中括号会影响键的存在性。

```
map<char, int> mp;
cout << mp.count('a') << endl; // 0
mp['a'];                       // 即使什么都没做，此时mp['a']=0已经插入了
cout << mp.count('a') << endl; // 1
cout << mp['a'] << endl;       // 0
```

##### 不可用迭代器计算下标

map 的迭代器不能像 vector 一样相减得到下标。**下面是错误用法：**

```c++
auto it = mp.find('a');      // 正确，返回2所在位置的迭代器。
int idx = it - mp.begin();   // 错误！不可相减得到下标。
```

### pair  二元组

**`#include <utility>`**

顾名思义，就是储存二元组的。

####  常用方法

#### 构造

**`pair<第一个值类型, 第二个值类型> pr`**

- 第一个值类型：要储存的第一个值的数据类型
- 第二个值类型：要储存的第二个值的数据类型

```
pair<int, int> p1;
pair<int, long long> p2;
pair<char, int> p3;
// ...
```

#### 赋值

老式

```
pair<int, char> pr = make_pair(1, 'a');
```

列表构造 C++11

```
pair<int, char> pr = {1, 'a'};
```

```C++
//构造单行的一维数组的二元组形式的动态数组然后用push_back读进目标二维数组去
vector<pair<int, int>> row;//一维数组
row.push_back({5, 6});
row.push_back({7, 8});
row.push_back({9, 10});
road.push_back(row);//读入目标二维数组
```

#### 取值

直接取值

- 取第一个值：`.first`
- 取第二个值：`.second`

```
pair<int, char> pr = {1, 'a'};
int awa = pr.first;
char bwb = pr.second;
```

结构化绑定 C++17

```
pair<int, char> pr = {1, 'a'};
auto &[awa, bwb] = pr;
```

#### 判同

直接用 `==` 运算符

```
pair<int, int> p1 = {1, 2};
pair<int, int> p2 = {1, 3};
if (p1 == p2) { ... } // false
```

### Tuple  三元组

**`#include< tuple >`**

tuple<类型，类型，类型>;

### n-tuple  n元组

读入方式：

```c++
ans.push_back({a,c,b,d});
```

或

```c++
ans.resize(xb + 1);  // 确保 ans[xb] 存在
ans[xb].push_back(nums[i]);
ans[xb].push_back(nums[j]);
ans[xb].push_back(nums[left]);
ans[xb].push_back(nums[right]);
xb++;
```

## 仿函数（FUnctors）

```
greater<int>()
```

## 迭代器（Iterators）

```
for (vector<int>::iterator it = a.begin(); it != a.end(); ++it)
    cout << *it << endl;
```

- a.begin() 是一个迭代器，指向的是第一个元素
- a.end() 是一个迭代器，指向的是最后一个元素再后面一位
- 上述迭代器具有自增运算符，自增则迭代器向下一个元素移动
- 迭代器与指针相似，如果对它使用解引用运算符，即 *it，就能取到对应值了

### 迭代器的作用

很多数据结构并不是线性的（例如红黑树），对于非线性数据结构，下标是无意义的。无法使用下标来遍历整个数据结构。

迭代器的作用就是定义某个数据结构的遍历方式，通过迭代器的增减，代表遍历到的位置，通过迭代器便能成功遍历非线性结构了。

例如，set 的实现是红黑树，我们是没法用下标来访问元素的。但是通过迭代器，我们就能遍历 set 中的元素了：

```
for (set<int>::iterator it = st.begin(); it != st.end(); ++it)
    cout << *it << endl;
```

### 迭代器的用法

对于 vector 容器，它的迭代器功能比较完整，以它举例：

- `.begin()`：头迭代器
- `.end()`：尾迭代器
- `.rbegin()`：反向头迭代器
- `.rend()`：反向尾迭代器
- 迭代器 `+` 整型：将迭代器向后移动
- 迭代器 `-` 整型：将迭代器向前移动
- 迭代器 `++`：将迭代器向后移动 1 位
- 迭代器 `--`：将迭代器向前移动 1 位
- 迭代器 `-` 迭代器：两个迭代器的距离
- `prev(it)`：返回 it 的前一个迭代器
- `next(it)`：返回 it 的后一个迭代器

对于其他容器，由于其结构特性，上面的功能不一定都有（例如 set 的迭代器是不能相减求距离的）

### 常见问题

**`.end()` 和 `.rend()` 指向的位置是无意义的值**

对于一个长度为 10 的数组：`for (int i = 0; i < 10; i++)`，第 10 位是不可访问的

对于一个长度为 10 的容器：`for (auto it = a.begin(); it != a.end(); ++it)`，.end 是不可访问的

**不同容器的迭代器功能可能不一样**

迭代器细化的话有正向、反向、双向，每个容器的迭代器支持的运算符也可能不同，因此不同容器的迭代器细节很有可能是不一样的。

**删除操作时需要警惕**

为什么 3 没删掉？

```
vector<int> a{1, 2, 3, 4};
for (auto it = a.begin(); it != a.end(); ++it)
    if (*it == 2 || *it == 3)
        a.erase(it);
// a = [1, 3, 4]
```

为啥 RE 了？

```
vector<int> a{1, 2, 3, 4};
for (auto it = a.begin(); it != a.end(); ++it)
    if (*it == 4)
        a.erase(it);
```

**建议：如无必要，别用迭代器操作容器。（遍历与访问没关系）**

# 头文件

###### #include<bits/stdc++.h>

万能头文件，可以使用几乎所有的标准库函数。在大型项目中显著增加编译时间。降低了代码的可读性和维护性。

## #include< cstdlib>

### 清空屏幕(.exe)

system(“cls”);

## #include< string>

可以看成是一个字符数组，下标默认从0开始存储

一个string串可以由两个字符串相加而成

```c++
string str1 = "Hello, ";
string str2 = "World!";
string result = str1 + str2;
// 结果为 "Hello, World!"
```

###### getline

（读取一行数据）用来读取用户输入的一行文本，直到遇到换行符						***即为不读取空行**

```c++
while (getline(file, line))  // 读取文件中的每一行
```

*file是文件指针，line是用于存储getline读取出来的东西的变量

###### find()

```c++
 string str = "123.456";
 size_t pos = str.find('.'); // 查找小数点
```

###### substr（）

*可用于提取字符串

例如：

```c++
	std::map<std::string, int> myMap;
    std::string str = "HelloWorld";

    // 提取子字符串并录入 map
    myMap[str.substr(0, 5)] = 1; // 提取 "Hello"
    myMap[str.substr(5, 5)] = 2; // 提取 "World"
```

1. **不带参数的调用**：`n.substr()` 返回一个包含整个原始字符串的副本。

2. **带参数的调用**：`n.substr(start, length)` 返回从索引 `start` 开始，长度为 `length` 的子串。如果 `length` 参数省略，那么子串将包含从 `start` 开始到字符串末尾的所有字符。

	*例子*

	```c++
	n = n.substr(1) + n[0];
	```

	将字符串第一个数位放在最后一位

	##### 字符串类型转换

	|                                                              |                                     |
	| ------------------------------------------------------------ | ----------------------------------- |
	| stoi(int)                                                                                                                                   stol(long)                                                                                                                         stoll(long long) | 转换字符串为有符号整数 (函数)       |
	| stoul                                                                                                                                      stoull | 转换字符串为无符号整数 (函数)       |
	| stof                                                                                                                                   stod                                                                                                                              stold | 转换字符串为浮点值 (函数)           |
	| to_string                                                    | 转换整数或浮点值为 `string` (函数)  |
	| to_wstring                                                   | 转换整数或浮点值为 `wstring` (函数) |

# 变量

###### 常量

```c++
const (变量名);  //常量
```

###### 无符号类型

```
size_t a;
```

使用于string的find()函数中，作为索引值的返回

## 全局变量

```c++
exturn int elements;
```

有两个源代码文件，此源代码文件中引用了另一个源代码文件中定义的整型的elements变量

## 静态局部变量

静态存储区

```c++
static c=3;
```

- 限制变量的作用域在当前文件内
- 避免与其他文件的同名变量冲突

第二次调用该函数的时候c值仍保留上次计算最后的原值

不仅可以在函数内部使用，一整个源代码文件内也可以

# 符号

## 转义字符

**\b**：退格符    将光标向左移动一个位置，但不删除光标当前位置的字符。

## 运算符

###### 常见的C语言运算符及其优先级（从高到低排列）：

1. **括号运算符 `()`**：用于改变运算的默认顺序。
2. **成员访问运算符 `.` 和 `->`**：用于访问结构体或联合体的成员。
3. **数组下标运算符 `[]`** 和 函数调用运算符 `()`（用于函数调用）。
4. **一元运算符**：包括后缀递增 `++`、后缀递减 `--`、取地址 `&`、间接访问（解引用）`*`、正号 `+`、负号 `-`、按位取反 `~`、逻辑非 `!` 和 大小比较运算符 `sizeof`。
5. **乘除运算符 `\*`、`/` 和 `%`**：用于乘法、除法和取余运算。
6. **加减运算符 `+` 和 `-`**：用于加法和减法运算。
7. **位移运算符 `<<` 和 `>>`**：用于位左移和位右移运算。
8. **比较运算符 `<`、`<=`、`>`、`>=`**：用于比较两个值的大小。
9. **等于运算符 `==` 和 不等于运算符 `!=`**：用于比较两个值是否相等或不等。
10. **按位与运算符 `&`**：用于按位与运算。
11. **按位异或运算符 `^`**：用于按位异或运算。
12. **按位或运算符 `|`**：用于按位或运算。
13. **逻辑与运算符 `&&`**：用于逻辑与运算，只有当两个操作数都为真时，结果才为真。
14. **逻辑或运算符 `||`**：用于逻辑或运算，只要有一个操作数为真，结果就为真。
15. **三元条件运算符 `?:`**：根据条件表达式的值选择两个值中的一个。
16. **赋值运算符 `=` 及其复合形式**：如 `+=`、`-=`、`*=` 等，用于赋值运算。
17. **逗号运算符 `,`**：用于顺序执行多个表达式，并返回最后一个表达式的值。

#### || 和 |

|| 和 | 都是表示“或”，区别是||只要满足第一个条件，后面的条件就不再判断，而|要对所有的条件进行判断。

### 条件运算符

条件表达式 ? 表达式1 : 表达式2

**工作原理**

• 条件表达式：这是一个布尔表达式，其值为  true  或  false  

• 表达式1：如果条件表达式为  true  ，则整个条件运算符的结果是  表达式1  的值

• 表达式2：如果条件表达式为  false  ，则整个条件运算符的结果是  表达式2  的值

# 选择

## switch

**不要忘了break语句**

```c++
switch (expression)
{
    case value1:
        // 当expression的值等于value1时执行的代码
        break;
    case value2:
        // 当expression的值等于value2时执行的代码
        break;
    // ...可以有更多的case语句
    default:
        // 如果expression的值不匹配任何case时执行的代码
}
```

###### 区间问题化用入switch

例：区间0~ 250、250~ 500、500 ~1000、1000 ~2000；

```c++
cin>>sj;     //sj=120
n=sj/250;    //120/250=0
swich(n)
    case 0: (0~250)的情况下执行的语句
```

# 循环

## goto语句

```c++
int i,sujm=0;
i=1;
loop:if(i<=100)
    {
        suam=sum+i;
        i++;
        goto loop;
    }
printf("%d\n",sum);
```

## 控制循环次数与速度

###### break

跳出单个循环体

###### continue

跳出单个循环，i++执行下一循环

# 数组

###### 数组遍历

```c++
for (auto ele : arr)
    cout << ele << endl;
```

•   for (auto ele : arr)  ：这是一个基于范围的for循环（range-based for loop），用于遍历   arr   容器中的每个元素。  auto   关键字表示自动推断变量   ele   的类型，  ele   是当前循环中   arr   容器的元素。

## 字符数组

*没有初始化的时候其值随机

# 字符串

###### strcat函数

连接两个字符串

###### strcpy函数

复制字符串1给字符串2

```c
char *strcpy(char *dest, const char *src);
```

- `dest`：目标字符串的指针，即复制到的位置。
- `src`：源字符串的指针，即从哪里复制。

#### 计算字符串长度

###### sizeof()

*动态数组不能使用*     ==包括最后的空字符 `\0`（如果有的话）==

  `sizeof` 运算符用于计算数据类型或变量的大小（以字节为单位）。当用于数组时，`sizeof` 会返回整个数组的总大小，包括所有元素，从下标为0的元素开始。

例如，如果您有一个数组 `int myArray[10];`，那么 `sizeof(myArray)` 将返回整个数组的大小，这包括了数组中下标为0的元素。数组的大小计算方式是元素数量乘以每个元素的大小。在这个例子中，如果 `int` 是4字节，那么 `sizeof(myArray)` 将返回 `10 * 4 = 40` 字节。(输出结果：40)下标：0~9，10个元素

###### strlen()

==因此，`strlen()` 不包括空字符 `\0` 在内，它计算的是字符串中字符的数量，直到但不包括 `\0`==

#### 字符串的比较

##### string库中

直接比较

```c++
int str1,str2;
if（str1==str2）
{
    ……
}
```

###### ==strcmp函数==

**功能**

`strcmp` 函数比较两个字符串 `str1` 和 `str2` 的字典顺序（即按字符的ASCII值进行比较）。比较是按字符从左到右的顺序进行的，直到找到不同的字符或者遇到字符串的结束符 `\0`。

**返回值**

- 如果 `str1` 在字典顺序上小于 `str2`，返回值大于0。
- 如果 `str1` 和 `str2` 相等，返回值等于0。
- 如果 `str1` 在字典顺序上大于 `str2`，返回值小于0。

# 函数

###### 特殊功能

==**isalnum(~~s[i]~~)** ：==

一个用于检查字符是否为字母或数字（即 **字母数字字符**）的函数。

是返回非零值，否返回0

| 函数                      | 作用           | 示例        |
| :------------------------ | :------------- | :---------- |
| ==`int tolower(int ch)`== | 将字符转为小写 | `'A' → 'a'` |
| ==`int toupper(int ch)`== | 将字符转为大写 | `'a' → 'A'` |

#### 内部函数&外部函数

exturn（外部函数）

static（内部函数）

#### 输入输出

##### 输入输出

###### scanf&printf

**%e**:小数位数为6位，以指数形式输出实数

###### cin&cout&cerr

cout：标准输出流

cerr：标准错误流

##### 输入输出字符（数组）

###### getchar

*读取字符的函数*

int getchar(void)

返回类型为int,参数为void.
1、getchar返回的是字符的ASCII码值（整数）
2、getchar在读取结束或者失败的时候，会返回EOF

==EOF意思是end of file,本质上是-1.==

**例子：scanf后getchar||getchar后getchar……等**

scanf和getchar都是输入函数，它们都是从键盘上来读取我们的数据，但它们不是直接从键盘上来读取我们的数据。它们和键盘之间有一个区域叫缓冲区。
输入函数先来看缓冲区中是否有数据，如果有，它直接就拿走了，不需要从键盘输入，如果缓冲区什么都没有，则需要从键盘输入，再拿走。

* 最开始缓冲区里没有东西 ![](https://i-blog.csdnimg.cn/blog_migrate/720ea284a3aa1f218b5b61961210db03.png)
*  从键盘输入123456

![在这里插入图片描述](https://i-blog.csdnimg.cn/blog_migrate/8a80ce363736af4b0fe7073e0e0bed4b.png)

- scanf来读缓冲区里的字符串

​       scanf读取的方式是读取\n之前的内容，所以读取的是123456

- getchar来读取数据

	getchar看到缓冲区中有数据（\n）,直接取走，不需要从键盘输入

![在这里插入图片描述](https://i-blog.csdnimg.cn/blog_migrate/1063acc88755d40b6d8a563563930778.png)

···········解决方法：再使用一个**getchar（）**把缓冲区的**\n**先清理掉

###### gets函数

<u>输入字符串进数组内</u>

由于*不安全*已经被大多数编译器弃用，容易导致**缓冲区溢出**等安全问题，常用*fgets函数*替代

###### fgets函数

fgets（容器地址，容器大小，从哪里读取）

*从哪里读取通常写为：stdin（标准输入流-键盘）

（补充一个知识：stdout-标准输出流-屏幕）

  还可以从文件中读取

例如：(文件指针fp)

```c++
fgets(str,n,fp)；//从fp指向的文件中，读入一个长度为（n-1）的
                 //字符串，存放到字符数组str中
```

末尾会读入‘\0‘和‘\n’两个位，\n在\0前

###### fputs函数（与fgets同理）

fputs（容器地址，输出到哪里）

### 文件

###### perror

`perror` 是 C 语言标准库中的一个函数，用于打印错误信息。当你在使用像 `fopen`、`fprintf`、`fscanf`、`printf`、`scanf`、`sprintf`、`sscanf` 等 I/O 函数时遇到错误，`perror` 可以提供一个描述最后一次错误的消息。

`perror` 函数的原型如下：

```c
void perror(const char *s);
```

这里的参数 `s` 是一个字符串，它会被放置在错误消息的前面。通常，这个字符串用来指明是哪部分代码发生了错误。`perror` 会将这个字符串和错误消息一起输出到 `stderr`（标准错误流），错误消息后面通常会跟着一个换行符。

## #include<stdlib.h>

#### 处理不确定大小的数据（运用内存分配）

###### malloc函数

https://blog.csdn.net/volta_xu/article/details/139041779?ops_request_misc=&request_id=&biz_id=102&utm_term=c%E8%AF%AD%E8%A8%80%E4%B8%AD%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8malloc&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduweb~default-0-139041779.142^v100^pc_search_result_base9&spm=1018.2226.3001.4187

## #include<math.h>

#### 计算x的y次方

pow(x,y);

#### 四舍五入取整

###### ceil()

函数是向上取整

###### floor()

 函数是向下取整

###### round()

函数是取其大约，即四舍五入取整

```c++
float num;
float a=round(num);
```

# 指针

## 指针定义

###### 指向一维数组的指针变量

```c++
int (*p)[4];
```

###### 指向函数的指针变量

```c++
int (*p)(int ,int );
```

###### 指向指针的指针变量

```c++
int **p;
```

###### 指针数组

```c++
int *p[4];
```

###### 返回指针类型的函数

```c++
int (*p)(int a,int b);
```



## 二维数组的指针

![image-20241102163719981](../AppData/Roaming/Typora/typora-user-images/image-20241102163719981.png)

![image-20241022235314437](../AppData/Roaming/Typora/typora-user-images/image-20241022235314437.png)



## 指针引用字符串

```c++
char *string="……";
printf("%s\n",string);
```

## 用数组名作函数参数时

实参数组名代表该数组首元素的地址：形参应该是一个指针变量

（C编译均将形参数组名作指针变量处理）

**int arr [ ]**     =    **int   * arr**

（适合用来指向若干个字符串）

*用指针数组排序，不用改变位置，只改变指针的指向

```c++
char *name[]={"……"，"……"，……};
```

###### **指针数组做main函数（即主函数）的形参**

```c++
int main(int argc,char *argv[])
```

argc、argv是main函数的形参（命令行参数）

**argv:**指针数组，数组中每一个元素指向命令行中的一个字符串

main函数与其他函数组成一个文件模块，第一串就是文件名

## 返回指针值的函数

### 普通版

**类型名    * 函数名(参数表列)**

```c++
int *max(int *p1,int *p2)
{
    if(*p1>*p2)
        return p1;  //返回p1的地址
}
int main()
{
    ……
    c=max(&a,&b);
}
```

###### 二维数组的指针

```c++
float *search(float (*pointer)[4],int n)  //pointer 是行指针
int main()
{
    float score[][4]={{……},{……}，……};
    ……
    float *p;
    p=search(score,k);  //返回k号学生首地址
    for(int i=0;i<4;i++)
        printf("%5.2f",*(p+i));
}
```



### 动态数组版

#### 题目描述

编写一个函数`getStudentGrades`，该函数接受两个参数：一个`std::vector<std::vector<int>>`类型的二维动态数组`grades`和一个整数`studentIndex`。函数应返回一个指向指定学生成绩数组的指针。如果`studentIndex`超出范围，函数应返回`nullptr`。

```c++
#include <iostream>
#include <vector>
// 函数声明
int* getStudentGrades(const std::vector<std::vector<int>>& grades, int studentIndex);


//主函数
int main()
{
    int a, b;
    std::cout << "请录入学生数量：\n";
    std::cin >> a;
    std::cout << "请录入课程数量：\n";
    std::cin >> b;
// 创建一个动态二维数组，第一维是学生，第二维是课程成绩
std::vector<std::vector<int>> grades(a, std::vector<int>(b));
std::cout << "请录入每个学生各个课程的成绩：\n";
for (int i = 0; i < a; i++)
{ // 行-学生
    for (int j = 0; j < b; j++) 
    { // 列-课程
        std::cin >> grades[i][j];
    }
} 
int studentIndex;
std::cout << "请选择你想知道的学生的成绩（索引从0开始）：\n";
std::cin >> studentIndex;
// 获取指定学生的成绩数组指针
int* studentGrades = getStudentGrades(grades, studentIndex);
if (studentGrades != nullptr)
{
    std::cout << "学生 " << studentIndex << " 的成绩为：";
    for (int i = 0; i < b; i++)
    {
        std::cout << studentGrades[i] << " ";
    }
    std::cout << std::endl;
} 
else 
{
    std::cout << "输入的学生索引超出范围。" << std::endl;
}
	return 0;
}


// 函数定义
int* getStudentGrades(const std::vector<std::vector<int>>& grades, int studentIndex) {
    if (studentIndex < 0 || studentIndex >= grades.size())
    {
        return nullptr;
    }
    return grades[studentIndex].data();
}
```

## 指向函数的指针变量

```c++
#include <iostream>

// 函数原型
int add(int, int);
int subtract(int, int);

int main() {
    // 指向函数的指针
    int (*functionPtr)(int, int);

// 将指针指向add函数
functionPtr = add;
std::cout << "10 + 5 = " << functionPtr(10, 5) << std::endl;

// 将指针指向subtract函数
functionPtr = subtract;
std::cout << "10 - 5 = " << functionPtr(10, 5) << std::endl;

return 0;

}

// add函数定义
int add(int a, int b) 
{
    return a + b;
}

// subtract函数定义
int subtract(int a, int b) {
    return a - b;
}
```

# 引用

 *指针子兄dei*		意思是给变量起一个小名

###### 格式

（类型名）&    （变量名）

例如：int&  a；

```c++
void minnnn(string& n)
```

# 类

###### 类的自引用

# 结构体

###### 易错点

*结构体需要有实例！！！*

```c++
struct jl
{
    int mm;
    int rr;
};
int main()
{
    struct jl ii;
    cin>>ii.mm;
    cin>>ii.rr;
}

```

### 传递结构体指针作为自定义函数的参数

C语言允许把(*p).num用p->num来代替

(*p).name等价于p->name

```c++
#include <iostream>
struct Person 
{
    std::string name;
    int age;
};
void updateAge(Person* p, int newAge) 
{
    p->age = newAge; // 使用箭头操作符访问成员
}
int main()
{
    Person person = {"John", 30};
    updateAge(&person, 31); // 传递地址
    return 0;
}
```

### 枚举类型

```c++
enum Week
{
	MONDAY=1,TUESDAY,WEDNESDAY,THUSDAY,FRIDAY,SATURDAY,SUNDAY
};
int main()
{
    enum Week;
    ……
    return 0;
}
```

# 文件

## 程序文件

## 数据文件

ASCII文件、二进制文件

###### 数据的存储

**字符：**一律以ASCII形式存储

**数值型：**二者都行，推荐二进制（省时间）0

##### fstream流

**==头文件：fstream==**

###### **打开文件**

**ios::in：**以输入模式打开文件，只能进行读操作。
**ios::out：**以输出模式打开文件，只能进行写操作。如果文件不存在，则创建一个新文件；如果文件已存在，则覆盖原有内容。
**ios::app：**以追加模式打开文件，只能进行写操作。如果文件不存在，则创建一个新文件；如果文件已存在，则在原有内容的末尾追加新内容。
**ios::ate：**以定位模式打开文件，可以进行读写操作。如果文件不存在，则创建一个新文件；如果文件已存在，则将文件指针定位到文件末尾。
**ios::binary**：以二进制模式打开文件，可以进行读写操作。这个模式会忽略换行符等特殊字符，按照字节流的方式处理文件。
**ios::trunc**：以截断模式打开文件，只能进行写操作。如果文件不存在，则创建一个新文件；如果文件已存在，则删除原有内容。

**ofstream** 相当于 fstream 的 ios::out。ofstream 是 fstream 的一种特殊类型，它只用于写入文件。当您使用 ofstream 打开文件时，它会自动将文件模式设置为 ios::out。这意味着您<u>只能写入文件</u>，而不能读取文件。

```c++
ofstream file("example.txt",app);
```

例子：

```c++
#include <fstream>
#include <iostream>
int main() 
{
    // 使用ofstream和ios::app模式在文件末尾追加数据
    std::ofstream file("example.txt", std::ios::app);

    if (!file.is_open()) 
    {
        std::cerr << "无法打开文件" << std::endl;
        return -1;
    }

    // 写入数据到文件末尾
    file << "这是追加的文本。" << std::endl;

    file.close(); // 关闭文件

    return 0;
}
```

**ifstream** 是 fstream 的另一种特殊类型，它只用于读取文件。当您使用 ifstream 打开文件时，它会自动将文件模式设置为 ios::in。这意味着您<u>只能读取文件</u>，而不能写入文件。

***打开该文件不成功不会创造一个该名字的文件**

例如：打开一个已有文件并读取其中的一行字符

```c++
	ifstream file("example.txt");
    string f;
    if (file.is_open()) 
	{
        getline(file,f);
        file.close();
    }
```

*以上模式可以用“|”符号组合使用，例如**ios::in | ios::binary**表示以输入二进制模式打开文件。

创建了一个fstream对象fs

```c++
#include <fstream>
using namespace std;

int main()
{
	fstream fs;
	fs.open("test.txt", ios::out | ios::app);
	// 尾部追加的写操作
	fs.close();
	return 0;
}
```

❗注意，在**使用完fstream对象后，需要调用close()函数关闭文件，释放资源**

❗对于同一个文件，ifstream和ofstream的文件流应该分开

例如：

```c++
ifstream file1("client.txt");
ofstream file2("client.txt",ios::app);
```

###### 读写操作

**<<：**向文件写入数据，例如fs << “Hello, world!” << endl;表示向文件写入一行字符串。**>>：**从文件读取数据，例如fs >> x;表示从文件读取一个整数赋值给变量x。
**getline()：**从文件读取一行字符串，例如<u>getline(fs, s);</u>表示从文件读取一行字符串赋值给变量s。



**修改文件里面的内容：**

**seekp**（写指针）&**seekg**（读指针）

```cpp
#include <fstream>
#include <iostream>
using namespace std;
int main() 
{
    fstream file("example.txt", ios::in | ios::out | ios::app);
    if (file.is_open()) 
    {
        // 移动到文件的第10个字符位置
        file.seekp(9); // 从文件开始位置向后移动9个字符

        // 在新位置写入数据
        file << "Hello, World!";

        file.close();
    } 
    return 0;
}
```



另外，还有一些常用的成员函数和标志位可以用来判断和控制fstream对象的状态。例如：

**is_open()：**判断是否成功打开了文件，例如if (fs.is_open())表示如果成功打开了文件，则执行后续操作。
**good()：**判断是否正常运行，没有发生错误或到达末尾，例如while (fs.good())表示当正常运行时，则循环执行后续操作。
**eof()：**判断是否到达了文件末尾，例如while (!fs.eof())表示当没有到达末尾时，则循环执行后续操作。
**fail()：**判断是否发生了非致命性错误（如类型不匹配），例如if (fs.fail())表示如果发生了非致命性错误，则执行后续操作。
**bad()：**判断是否发生了致命性错误（如磁盘损坏），例如if (fs.bad())表示如果发生了致命性错误，则执行后续操作。
**clear()：**清除错误标志位，恢复正常状态，例如fs.clear();表示清除错误标志位。
**setstate()：**设置错误标志位为指定状态，例如fs.setstate(ios::failbit);表示设置错误标志位为非致命性错误状态。

#### 打开与关闭文件

###### fopen函数

|      | 作用                                                         |
| ---- | ------------------------------------------------------------ |
| "r"  | 打开一个用于读取的文件。该文件必须存在。                     |
| "w"  | 创建一个用于写入的空文件。如果文件名称与已存在的文件相同，则会删除已有文件的内容，文件被视为一个新的空文件。 |
| "a"  | 追加到一个文件。写操作向文件末尾追加数据。如果文件不存在，则创建文件。 |
| "r+" | 打开一个用于更新的文件，可读取也可写入。该文件必须存在。     |
| "w+" | 创建一个用于读写的空文件。                                   |
| "a+" | 打开一个用于读取和追加的文件。                               |

*内含文件指针

```c++
FILE *fp;
fp=fopen("(文件名)","r");  //r为只读
fclose(fp);
```

（返回值）*如果用fopen函数的r方式打开一个不存在的文件，会返回一个**NULL值**

~~打开文件成功的话返回文件指针（赋值给fp），打开失败则返回 NULL值~~

```c++
FILE *fp = fopen("不存在的文件.txt", "r");
if (fp == NULL) {
    // 文件不存在或无法打开，处理错误
    perror("Error opening file");
} else {
    // 文件成功打开，可以进行读取操作
    fclose(fp);
}
```

**fopen**不安全，建议用**fopen_s**替代

###### fopen_s函数

fopen的用法是: fp = fopen(“filename”,“w”);
对于fopen_s来说，还得定义另外一个变量 errno_t err，
然后err = fopen_s(&fp,“filename”,“w”)；

（返回值）fopen_s：打开文件成功返回0，失败返回非0。

#### 数据的读写

##### fwrite(需要读入文件的数据 存储的地址，要读写的字节数，要读写的数据项个数，FILE类型指针)

```c++
int a=66;
fwrite(&a, sizeof(int), 1, fp);
```

**文件用记事本打开会显示部分乱码**：编码问题，记事本不支持二进制数据

# 控制台

## 清空

**清空整个屏幕：**
（头文件<cstdlib>)

system(“cls”);

**清空特定的某一行：**

- 若是清空方才输出的那一行

使用  \r  将光标移到该行行首，再输出指定字符可将方才输出的字符覆盖掉

若方才的输出长度大于再次输出的长度，可用空格等字符覆盖掉方才的输出

- 若是清空特定的某一行

​       使用**ANSI转义代码**

```c++
#include <iostream>
#include<windows.h>
#include<cstdio>
using namespace std;
int main() 
{
	cout<<"111111111111111";
	Sleep(1000);
	cout<<"\033[1A";
	printf("\r");
	Sleep(2000);
	cout<<"2222222         ";
    return 0;
}
```

==**（附录）一些常用的ANSI转义码**==

**光标控制**

\033[H：将光标移动到屏幕的左上角（0,0）位置。
\033[{行};{列}H：将光标移动到指定的行和列。
\033[A：光标上移一行。
\033[B：光标下移一行。
\033[C：光标右移一行。
\033[D：光标左移一行。

**清除屏幕**

\033[2J：清除屏幕上的所有内容，并将光标移动到左上角。
\033[J：清除屏幕从光标位置到下方的所有内容
\033[1J：清除屏幕从光标位置到上方的所有内容
\033[K：清除从当前光标位置到行末的所有内容。

**文本样式**

\033[0m：重置所有样式。
\033[1m：设置高亮（Bright）模式。
\033[4m：设置下划线。
\033[7m：设置反显（Inverse）模式。
\033[30m 到 \033[37m：设置前景色（文字颜色）。
\033[40m 到 \033[47m：设置背景色。

**字体样式**

\033[1m：粗体。
\033[3m：斜体。
\033[4m：下划线。
\033[9m：删除线。
请注意，\033 是 ESC 字符（ASCII码27）的八进制表示，你也可以使用十六进制表示法 \x1b。

# 一些血泪史

## 溢出

#### 数组过大导致溢出

#### 类型溢出

```c++
long long sum = nums[i] + nums[j] + nums[l] + nums[r];
```

这个错误是因为你在进行整数加法时发生了**有符号整数溢出**（signed integer overflow）。具体来说，`nums[i] + nums[j] + nums[l] + nums[r]` 的计算结果超出了 `int`（32位有符号整数）的最大范围（`2,147,483,647`），导致未定义行为（undefined behavior）。

```c++
long long sum = 0LL + nums[i] + nums[j] + nums[l] + nums[r];
```

###### 加法溢出

l+(r-l)/2   //替换掉(l+r)/2

## 数组越界