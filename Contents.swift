import Foundation
//~~~~~~~~~~~~~~~~~~~~~~~~~~ Dispatch Queue ~~~~~~~~~~~~~~~~~~~~~~~~~~
/*
    
    // Thread     // Task
    Serial     +    Sync    -> Order
    Serial     +    Async   -> Order
    Concurrent +    Sync    -> Order
    Concurrent +    Async   -> Unorder
 
 */

/*
let concurrentQueue = DispatchQueue(label: "prashant.concurrent.queue", attributes: .concurrent)

// One Thread
concurrentQueue.async {
    print("Task 1 started")
    
    for index in 1...5 {
        print("\(index) Task-1 times 5 is \(index * 5)")
    }
    
    print("Task 1 finished")
}

// Second Thread
concurrentQueue.async {
    print("Task 2 started")
    
    for index in 1...5 {
        print("\(index) Task-2 times 2 is \(index * 2)")
    }
    
    print("Task 2 finished")
}
 */

//~~~~~~~~~~~~~~~~~~~~~~~~~~ Dispatch Group ~~~~~~~~~~~~~~~~~~~~~~~~~~
/*
let group = DispatchGroup()
let queue = DispatchQueue(label: "prashant.concurrent.queue1")
let someQueue = DispatchQueue(label: "prashant.concurrent.queue2")

queue.async(group: group) {
    for _ in 0...25 {
        print("Queue - Task one running")
    }
}
queue.async(group: group) {
    for _ in 0...15 {
        print("Queue - Task two running")
    }
}
someQueue.async(group: group) {
    for _ in 0...45 {
        print("SomeQueue - Task one running")
    }
}

group.notify(queue: DispatchQueue.main) {
    print("All Jobs have done")
}
 */

// Waiting Group
let group1 = DispatchGroup()
let queue1 = DispatchQueue(label: "prashant.concurrent.queue3", attributes: .concurrent)

queue1.async(group: group1) {
    print("Start job 1")
    Thread.sleep(until: Date().addingTimeInterval(15))
    print("End job 1")
}
queue1.async(group: group1) {
    print("Start job 2")
    Thread.sleep(until: Date().addingTimeInterval(2))
    print("End job 2")
}

if group1.wait(timeout: .now() + 5) == .timedOut {
    // This will notify all task is not completed within 5 sec but still task will be running on background
    print("I got tired of waiting")
} else {
    print("All the jobs have completed")
}
