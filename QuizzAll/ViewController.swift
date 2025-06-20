//
//  ViewController.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 01/04/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation


class ViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet var ui_launch_game_01: UIButton!
    @IBOutlet var ui_launch_game_02: UIButton!
    @IBOutlet var ui_launch_game_03: UIButton!
    @IBOutlet var ui_launch_game_04: UIButton!
    @IBOutlet var ui_launch_game_05: UIButton!
    
    
    @IBOutlet weak var view_choix: UIView!
    @IBOutlet weak var pixel_purple_1: UIImageView!
    @IBOutlet weak var pixel_purple_2: UIImageView!
    @IBOutlet weak var pixel_purple_3: UIImageView!
                                                                                    // pixel 1 2
    @IBOutlet weak var pixel12: UIImageView!
    @IBOutlet weak var pixel13: UIImageView!
    @IBOutlet weak var pixel14: UIImageView!
    @IBOutlet weak var pixel15: UIImageView!
    @IBOutlet weak var pixel16: UIImageView!
    
    @IBOutlet weak var pixel22: UIImageView!
    @IBOutlet weak var pixel23: UIImageView!
    @IBOutlet weak var pixel24: UIImageView!
    @IBOutlet weak var pixel25: UIImageView!
    @IBOutlet weak var pixel26: UIImageView!
    
    @IBOutlet weak var pixel32: UIImageView!
    @IBOutlet weak var pixel33: UIImageView!
    @IBOutlet weak var pixel34: UIImageView!
    @IBOutlet weak var pixel35: UIImageView!
    @IBOutlet weak var pixel36: UIImageView!
    
    @IBOutlet weak var ui_double: UILabel!
    @IBOutlet weak var ui_breakout: UILabel!
    
                                                                            // Fonctions animations
    func animatePixel() {
        animPix1(); animPix12();animPix13(); animPix14(); animPix15();
        animPix16(); animPix2(); animPix22(); animPix23(); animPix24();
        animPix25(); animPix26(); animPix3(); animPix32(); animPix33();
        animPix34(); animPix35(); animPix36()
    }
    
    func animPix1() {
    UIView.animate(withDuration: 0.75,delay: 0, animations: {
            self.pixel_purple_1.center = CGPoint(x: 370, y: 10)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel_purple_1.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel_purple_1.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.pixel_purple_1.center = CGPoint(x: 10, y: 10)
                    }, completion: { (true) in
                        self.animPix1()
                    })
                })
            })
        }
    }
    func animPix12() {
        UIView.animate(withDuration: 0.75,delay: 0.1, animations: {
            self.pixel12.center = CGPoint(x: 370, y: 10)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel12.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel12.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.pixel12.center = CGPoint(x: 10, y: 10)
                    }, completion: { (true) in
                        self.animPix12()
                    })
                })
            })
        }
    }
    func animPix13() {
        UIView.animate(withDuration: 0.75,delay: 0.2, animations: {
            self.pixel13.center = CGPoint(x: 370, y: 10)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel13.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel13.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.pixel13.center = CGPoint(x: 10, y: 10)
                    }, completion: { (true) in
                        self.animPix13()
                    })
                })
            })
        }
    }
    func animPix14() {
        UIView.animate(withDuration: 0.75,delay: 0.3, animations: {
            self.pixel14.center = CGPoint(x: 370, y: 10)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel14.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel14.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.pixel14.center = CGPoint(x: 10, y: 10)
                    }, completion: { (true) in
                        self.animPix14()
                    })
                })
            })
        }
    }
    func animPix15() {
        UIView.animate(withDuration: 0.75,delay: 0.4, animations: {
            self.pixel15.center = CGPoint(x: 370, y: 10)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel15.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel15.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.pixel15.center = CGPoint(x: 10, y: 10)
                    }, completion: { (true) in
                        self.animPix15()
                    })
                })
            })
        }
    }
    func animPix16() {
        UIView.animate(withDuration: 0.75,delay: 0.5, animations: {
            self.pixel16.center = CGPoint(x: 370, y: 10)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel16.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel16.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.pixel16.center = CGPoint(x: 10, y: 10)
                    }, completion: { (true) in
                        self.animPix16()
                    })
                })
            })
        }
    }
    func animPix2() {
        UIView.animate(withDuration: 0.85,delay: 0, animations: {
            self.pixel_purple_2.center = CGPoint(x: 370, y: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.45, animations: {
                self.pixel_purple_2.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel_purple_2.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.35, animations: {
                        self.pixel_purple_2.center = CGPoint(x: 0, y: 0)
                    }, completion: { (true) in
                        self.animPix2()
                    })
                })
            })
        }
    }
    
    func animPix22() {
        UIView.animate(withDuration: 0.75,delay: 0.1, animations: {
            self.pixel22.center = CGPoint(x: 370, y: 10)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel22.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel22.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.pixel22.center = CGPoint(x: 10, y: 10)
                    }, completion: { (true) in
                        self.animPix22()
                    })
                })
            })
        }
    }
    func animPix23() {
        UIView.animate(withDuration: 0.75,delay: 0.2, animations: {
            self.pixel23.center = CGPoint(x: 370, y: 10)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel23.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel23.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.pixel23.center = CGPoint(x: 10, y: 10)
                    }, completion: { (true) in
                        self.animPix23()
                    })
                })
            })
        }
    }
    func animPix24() {
        UIView.animate(withDuration: 0.75,delay: 0.3, animations: {
            self.pixel24.center = CGPoint(x: 370, y: 10)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel24.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel24.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.pixel24.center = CGPoint(x: 10, y: 10)
                    }, completion: { (true) in
                        self.animPix24()
                    })
                })
            })
        }
    }
    func animPix25() {
        UIView.animate(withDuration: 0.75,delay: 0.4, animations: {
            self.pixel25.center = CGPoint(x: 370, y: 10)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel25.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel25.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.pixel25.center = CGPoint(x: 10, y: 10)
                    }, completion: { (true) in
                        self.animPix25()
                    })
                })
            })
        }
    }
    func animPix26() {
        UIView.animate(withDuration: 0.75,delay: 0.5, animations: {
            self.pixel26.center = CGPoint(x: 370, y: 10)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel26.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel26.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.pixel26.center = CGPoint(x: 10, y: 10)
                    }, completion: { (true) in
                        self.animPix26()
                    })
                })
            })
        }
    }
    func animPix3() {
        
        UIView.animate(withDuration: 0.55,delay: 0, animations: {
            self.pixel_purple_3.center = CGPoint(x: 370, y: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel_purple_3.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel_purple_3.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.25, animations: {
                        self.pixel_purple_3.center = CGPoint(x: 0, y: 0)
                    }, completion: { (true) in
                        self.animPix3()
                    })
                })
            })
        }
    }
    func animPix32() {
        UIView.animate(withDuration: 0.55,delay: 0.1, animations: {
            self.pixel32.center = CGPoint(x: 370, y: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel32.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel32.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.25, animations: {
                        self.pixel32.center = CGPoint(x: 0, y: 0)
                    }, completion: { (true) in
                        self.animPix32()
                    })
                })
            })
        }
    }
    func animPix33() {
        
        UIView.animate(withDuration: 0.55,delay: 0.2, animations: {
            self.pixel33.center = CGPoint(x: 370, y: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel33.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel33.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.25, animations: {
                        self.pixel33.center = CGPoint(x: 0, y: 0)
                    }, completion: { (true) in
                        self.animPix33()
                    })
                })
            })
        }
    }
    func animPix34() {
        UIView.animate(withDuration: 0.55,delay: 0.3, animations: {
            self.pixel34.center = CGPoint(x: 370, y: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel34.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel34.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.25, animations: {
                        self.pixel34.center = CGPoint(x: 0, y: 0)
                    }, completion: { (true) in
                        self.animPix34()
                    })
                })
            })
        }
    }
    func animPix35() {
        UIView.animate(withDuration: 0.55,delay: 0.4, animations: {
            self.pixel35.center = CGPoint(x: 370, y: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel35.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel35.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.25, animations: {
                        self.pixel35.center = CGPoint(x: 0, y: 0)
                    }, completion: { (true) in
                        self.animPix35()
                    })
                })
            })
        }
    }
    func animPix36() {
        UIView.animate(withDuration: 0.55,delay: 0.5, animations: {
            self.pixel36.center = CGPoint(x: 370, y: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.35, animations: {
                self.pixel36.center = CGPoint(x: 370, y: 70)
            }, completion: { (true) in
                UIView.animate(withDuration: 0.65, animations: {
                    self.pixel36.center = CGPoint(x: 10, y: 70)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.25, animations: {
                        self.pixel36.center = CGPoint(x: 0, y: 0)
                    }, completion: { (true) in
                        self.animPix36()
                    })
                })
            })
        }
    }
    
    func animateChoix() {
        UIView.animateKeyframes(withDuration: 2, delay: 3, options: [], animations: {
            self.view_choix.alpha = 1
        }, completion: nil)
    }
    func animateDoubleBreakOut() {
        UIView.animate(withDuration: 0.75, delay: 1.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            self.ui_breakout.center = CGPoint(x: 207, y: 114)
        }) { (true) in
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: [.autoreverse, .repeat], animations: {
                self.ui_breakout.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: nil)
            
        }
        
        UIView.animate(withDuration: 0.75, delay: 0.5, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.8, options: [], animations: {
            self.ui_double.center = CGPoint(x: 207, y: 50)
        }) { (true) in
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: [.autoreverse, .repeat], animations: {
                self.ui_double.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        animateDoubleBreakOut()
        animateChoix()
        animatePixel()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
