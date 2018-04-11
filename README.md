# PrototypePattern
![](https://upload-images.jianshu.io/upload_images/3265534-8e38d115beda90dd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

原型模式（Prototype Pattern）是用于创建重复的对象，同时又能保证性能。这种类型的设计模式属于创建型模式，它提供了一种创建对象的最佳方式。
这种模式是实现了一个原型接口（协议），该接口（协议）用于创建当前对象的克隆。当直接创建对象的代价比较大时，则采用这种模式。
### 介绍
**意图**：用原型实例指定创建对象的种类，并且通过拷贝这些原型创建新的对象。

**主要解决**：在运行期建立和删除原型。

**何时使用**： 1、当一个系统应该独立于它的产品创建，构成和表示时。 2、当要实例化的类是在运行时刻指定时，例如，通过动态装载。 3、为了避免创建一个与产品类层次平行的工厂类层次时。 4、当一个类的实例只能有几个不同状态组合中的一种时。建立相应数目的原型并克隆它们可能比每次用合适的状态手工实例化该类更方便一些。

**如何解决**：利用已有的一个原型对象，快速地生成和原型对象一样的实例。

**优点**： 1、性能提高。 2、逃避构造函数的约束。

**缺点**： 1、配备克隆方法需要对类的功能进行通盘考虑，这对于全新的类不是很难，但对于已有的类不一定很容易，特别当一个类引用不支持串行化的间接对象，或者引用含有循环结构的时候。 2、必须实现克隆接口。

**应用场景**：1、当我们编写组件需要创建新的实例对象，但是又不想依赖于初始化操作(不依赖于构造器、构造方法)。2、初始化过程需要消耗非常大的资源(数据资源、系统资源等等...)。3、构造方法需要很多初始化参数时。

### 原型模式：
####  建模：
![](https://upload-images.jianshu.io/upload_images/3265534-2512eaee1f471053.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


#### Step 1：
图个方便，此处我们使用系统的 `<NSCopying>` 协议（也可以自己实现）
```
@protocol NSCopying
- (id)copyWithZone:(nullable NSZone *)zone;
@end
```
#### Step 2：
创建遵循 `<NSCopying>` 协议的user类 `UserObject` ，并实现协议方法
```
// .h
#import <Foundation/Foundation.h>
@interface UserObject : NSObject<NSCopying>

/** 姓名 */
@property(nonatomic, copy) NSString *name;
/** 性别 */
@property(nonatomic, copy) NSString *sex;

// 构造函数
- (instancetype)initWithName:(NSString *)name
sex:(NSString *)sex;
@end

// .m
#import "UserObject.h"

@implementation UserObject

- (instancetype)initWithName:(NSString *)name
sex:(NSString *)sex
{
self = [super init];
if (self) {
_name = name;
_sex = sex;
}
return self;
}

// copy修饰符的实现方法是 copyWithZone：
/**
以前开发程序时，会据此把内存分成不同的“区”(zone）,而对象会创建在某个区里面。
现在不用了，每个程序只有一个区：“默认区”（default zone）.
*/
- (id)copyWithZone:(NSZone *)zone {
UserObject *copyUser = [[[self class] allocWithZone:zone] initWithName:_name
sex:_sex];    
return  copyUser;
}

@end

```
#### Step 3：
在 ViewController 中测试下：
```
UserObject *user = [[UserObject alloc] initWithName:@"小明" sex:@"男"];
UserObject *copyUser = [user copy];
user.name = @"小红";
NSLog(@"原型对象<%p>的name=%@",user,user.name);
NSLog(@"克隆对象<%p>的name=%@",copyUser,copyUser.name);
```
控制台效果：       
![](https://upload-images.jianshu.io/upload_images/3265534-5d9c0fdb192a7edf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
*查看对象内存地址，通过copy生成了一个新的对象，所以修改`user.name`, 克隆的对象不会受到影响。*
***
#### Q：这里就可以说 copy/mutableCopy 方法会进行深拷贝么？
####  A：错！！！  
**（因为在 `copyWithZone:` 方法中实现了 `allocWithZone:` ,会为拷贝的对象分配一个新的内存地址，从而生成了一个全新的对象返回出去）**

**如果我们将 `copyWithZone:` 方法改为如下实现：**
```
// copy修饰符的实现方法是 copyWithZone：
- (id)copyWithZone:(NSZone *)zone {
UserObject *copyUser = [self initWithName:_name
sex:_sex
friends:_friendsArr];   
return  copyUser;
}
```
![copy返回的还是同一对象](https://upload-images.jianshu.io/upload_images/3265534-98b73a7418603c2b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
**（对于我们创建的类是否是深拷贝，还要看具体的代码实现。）**
***

#### 深拷贝 / 浅拷贝 这里就不再阐述了，大家可以通过下面的文章结合学习~
[《Effective Objective-C 2.0》 第二十二条：理解 NSCopying 协议]()
[iOS 集合的深复制与浅复制](https://www.zybuluo.com/MicroCai/note/50592)

千里之行，始于足下。
