
export function promisify(fn) {
  return function (data) {
    return new Promise((resolve, reject) => {
      fn(data, (error, value) => {
        if (error) {
          reject(error)
        } else {
          resolve(value)
        }
      })
    })
  }
};

export function all(promises) {

  if (promises === undefined) return Promise.resolve()
  if (promises.length == 0) return Promise.resolve([]);
  let results = []
  let p = promises[0]
  for (let i = 1; i <= promises.length; i++) {
    p = p.then(value => {
      results.push(value)
      if (i < promises.length) return promises[i]
      return results
    })
  }
  return p
};

export function allSettled(promises) {

  if (promises === undefined) return Promise.resolve()
  if (promises.length == 0) return Promise.resolve([]);
  let results = []
  let p = promises[0]
  for (let i = 1; i <= promises.length; i++) {
    p = p.then(value => {
      results.push(value)
      if (i < promises.length) return promises[i]
      return results
    }, reason => {
      results.push(reason)
      if (i < promises.length) return promises[i]
      return results
    })
  }
  return p
};


export function race(promises) {

  if (promises === undefined) return Promise.resolve()
  if (promises.length == 0) return Promise.resolve([]);
  return new Promise((resolve, reject) => {
    for (const promise of promises) {
      promise.then(value => { resolve(value) },
        reason => { reject(reason) })
    }
  })
};


export function any(promises) {

  if (promises === undefined) return Promise.resolve()
  if (promises.length == 0) return Promise.resolve([]);
  return new Promise((resolve, reject) => {
    let errors = []
    for (const promise of promises) {
      promise.then(value => { resolve(value) },
        reason => {
          errors.push(reason)
          if (errors.length == promises.length) reject(errors)
        })
    }
  })
};