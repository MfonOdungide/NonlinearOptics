
# Copyright Mfon Odungide InvasionSystemsInc invasionsystems.blogspot.com

######### global import statements  ###########
#import platform#
import math



#########  global variable declarations  ###########
const = 1239.856


#########  class declerations  ###########
class displayResult:
    dash = '==============================================='
    dott = '...............................................'
    

    def longLine(self):
        print(self.dash)
    def dots(self):
        print(self.dott)
    def result(self,*args):
        self.dots()
        print(f'''    Bandgap Energy      = {args[0]:.2f} eV
    Composition         = {args[1]:.2f} % 
    Refractive Index    = {args[2]:.2f} 
    Wavelength          = {args[3]:.0f} nm
    Material is {args[4]}!''')
        self.dots()
        self.longLine()
    
    def getInput(self,phrase):
        phrase = input("")
        # phrase = input({})
        print(phrase)
        
    # def getConc():
    #     concInput = input('Input the Concentration of Alumimium in Al(x)Ga(1-x)As in % ')
    #     conc = int(concInput) / 100
    #     return (conc)

#########  methods declerations  ###########

def selection():
    global const

    Lambda, Eg_eV, i  = 0, 0, 2 #initializing variables
    # Eg, conc = computeEg()  
    disp = displayResult()
    disp.longLine()
    while (i != 0):
        sel = input('For Al(x)Ga(1-x)As, Select:\n[1] to Compute Energy Gap \n[2] to compute Wavelength \n[0] for neither \nSelection = ')
        if (sel == '1') or (i == 1):
            Lambda, Eg_eV = computeLamnda()
            break
        elif sel == '2':
            Lambda, Eg_eV = computeEg_eV()
            break
        elif sel == '0':
            # initializing variable. function is a tuple but only need Eg_eV
            # Eg_eV, conc = computeEg()
            # Lambda = const/float(Eg_eV)
            # return (Eg_eV, conc)
            # computeN()
            break
        elif (sel != '1' and sel != '2' ):
            print('''Select options [1], [2], [0] by typing 1, 2 or 0 on Keyboard
                or leave blank for default [1] selection''')

        i -= 1
        # absorb = materialAbsorb(Eg, Eg_eV)

    return float(Lambda), float(Eg_eV), sel

def getConc():
    concInput = input('Input the Concentration of Alumimium in Al(x)Ga(1-x)As in percentage (%): ')
    conc = int(concInput) / 100
    return (conc)

def computeEg(*args):
    x = getConc() #get the input concentration
    if (x > 0.45):
        Eg = 1.9+0.125* x+0.143* x* x
    else:
        Eg = (1.424 + 1.247*x)
    return Eg, x

def computeEg_eV():
    global const
    Lambda = input('Input the Bandgap Wavelength in nm of Al(x)Ga(1-x)As  ')
    Eg_eV = const/float(Lambda)
    return Eg_eV, Lambda

def computeLamnda():
    global const
    Eg_eV = input('Input the Bandgap Energy in eV of Al(x)Ga(1-x)As  ')
    Lambda = const/float(Eg_eV)
    return  Eg_eV, Lambda
# def computeE
def materialAbsorb(Eg, Eg_eV):
    if Eg_eV >= Eg:
        absorb = 'Absorbing'
    else:
        absorb = 'Not Absorbing'
    return absorb

def computeN():
    Eg, x = computeEg()
    Eg_eV, Lambda = selection() #get the computation selection
    E0 = (1.425 + (1.155 * x) + (0.37 * x * x))
    delta_E0 = (1.765 + (1.115 * x) + (0.37 * x * x))
    chi = float(Eg_eV)/E0
    chio = float(Eg_eV)/delta_E0
    f = (2 - ((1+chi)**0.5) - (1-chi)**0.5) / ((chi * chi))
    fo = (2 - ((1+chio)**0.5) - ((1-chio)**0.5)) /(chio*chio)
    bruch = 0.5*(E0/(delta_E0**1.5))
    A0 =6.3 + (19.0 * x)
    B0 = 9.4 - (10.2 * x)

    n1 = ((A0*(f+bruch*fo)+B0)**0.5) #swapped for testing complex conjugate
    n = (n1.real)
    # Test Parameter
    # print (f'lambda = {Lambda}, \nEg = {Eg},\nEg_eV = {Eg_eV},\nA0 = {A0},\nB0 = {B0},\nx = {x}, \nf = {f},\nfo = {fo}, \nE0 = {E0}, \nn1 = {n1}, \nbruch = {bruch}, \nchi = {chi}, \nn = {n}.')
    return Eg_eV, n, Lambda, Eg, x
    
######### main block  ###########

def main():
    disp = displayResult()
    disp.longLine()
    Eg_eV, n, Lambda, Eg, x = computeN()
    conc = x*100 # changing back to display answer in percentage
    absorb = materialAbsorb(Eg, Eg_eV)
    
    #disp.longLine()
    disp.result(Eg_eV, conc, n, Lambda, absorb) # (Eg | Conc | n | lambda)



if __name__ == '__main__': main()
