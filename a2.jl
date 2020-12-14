

#Dates package to work with dates and time
using Dates

#Need to: import Pkg; Pkg.add("Images")
#and import Pkg; Pkg.add("ImageView") for displaying images
using Images
using ImageView

#import Pkg; Pkg.add("CSV")
using CSV


#divisors
#----------------------------
function divisors(n)
	divisors = Int64[]
	for i in 1:n
		if n % i == 0
			push!(divisors, i)
		end
	end
	return(divisors)
end

#primes
#----------------------------
#boolean function checks if number is prime
function isPrime(n)
	q = floor(sqrt(n))
	for i in 2:n
		if n % i == 0
			return false
		end
	return true
	end
end
			
function primes(n)
	primeList = Int64[]
	push!(primeList, 2)
	for i in 2:n
		if isPrime(i)
			push!(primeList, i)
		end
	end
	return(primeList)
end
	
#pythagorean triples
#----------------------------
function pythagorean(n)
	for c in 1:n
		for a in 1:c
			for b in 1:a
				if a^2 + b^2 == c^2
					list = (b,a,c)
					print(list)
				end
			end
		end
	end
end

#join
#----------------------------
function joiner(j, k)
	k = join(k, j)
	print(k)
	print("\n")
end

#----------------------------
#isPrimeDay
function isPrimeDay()
	dateToday = today()
	dayOfMonth = day(dateToday)
	if isPrime(dayOfMonth)
		print("true")
		return true
		end
	println("Not prime day!")
	return false
end

#isFriday
function isFriday()
	currentDay = dayname(now())
	if currentDay == "Friday"
		print("true")
		print("\n")
		return true
		end
	print("\n")
	return false
end



#mergesort
#----------------------------
function mergeSort(myArray)
	if length(myArray) > 1
	#trunc() returns nearest integral value of same type 
		midPoint = trunc(Int, length(myArray)/2)
		leftHalf = myArray[1:midPoint]
		rightHalf = myArray[midPoint+1:end]
		mergeSort(leftHalf)
		mergeSort(rightHalf)
		i = 1
		j = 1
		k = 1
		while i <= length(leftHalf) && j <= length(rightHalf)
			if leftHalf[i] < rightHalf[j]
				myArray[k] = leftHalf[i]
				i += 1
			else
				myArray[k] = rightHalf[j]
				j += 1
			end
			k += 1
		end
		while i <= length(leftHalf)
			myArray[k] = leftHalf[i]
			i += 1
			k += 1
		end
		while j <= length(rightHalf)
			myArray[k] = rightHalf[j]
			j += 1
			k+= 1
		end
		#return(myArray)
	end
	print(myArray)
end

#Some sample programs
#----------------------------
#Gets an English country name and outputs the German name
function englishToOtherLangs()	
#	print("Enter a country name: ")
#	name = readline()
	name = "Germany"
	
	#get German and Russian data from .csv files
	germanData = CSV.File("germandatatable.csv")
	russianData = CSV.File("russiandatatable.csv")
	#check for name in German data
	for row in germanData
		if contains(row.English, name)
			println(name, " is ", row.German, " in German.")
			end
		end
	#check for name in Russian data
	for row in russianData
		if contains(row.English, name)
			println(name, " is ", row.Russian, " in Russian.")
			end
		end
end


#Displays an image, and gets the # of pixels in the image
function displayImage()
	#gets the path to the .jpg file
	imgPath = ".julia/sourpatch.jpg"
	#loads the image
	img = load(imgPath)
	#displays the image in ImageView
	imshow(img)
	H = height(img)
	W = width(img)
	totalPixels = H * W
	println("There are a total of ", totalPixels, " pixels in this image")
	bluePixels = 0
	rgbArr(img) = begin
		#creates an array of 0s, of size H by W
		arr = zeros(H, W)
		for w in 1:W
			for h in 1:H
				RGB = img[h,w]
				arr[h,w,1] = RGB.(r)
				arr[h,w,2] = RGB.(g)
				arr[h,w,3] = RGB.(b)
				if RGB.b > 150 && RGB.b > RGB.r && RGB.b > RGB.g
					bluePixels += 1
				end
			end
		end
	end		
	percentBlue = (100 * bluePixels) / totalPixels
	println("There are ", percentBlue, " blue pixels in this image")
end


function main()
	n = 10
	n2 = 7
	
	#Divisors
	println("Divisors of 10 are: ", divisors(n))
	print("\n")
	
	#Primes
	println("Primes of 7 are: ", primes(7))
	print("\n")
	
	#Pythagorean
	print("Pythagorean triples of 10 are: ")
	pythagorean(n)
	print("\n")
	
	#Joiner
	print("\n")
	print("Joiner: ")
	joiner("+", ["1","2","3","4","5"])
	
	#Mergesort
	print("\n")
	println("Mergesort with input [9,8,7,6,5,4,3,2,1] : ")
	mergeSort([9,8,7,6,5,4,3,2,1])
	print("\n")
	
	#isPrimeDay
	print("\n")
	print("isPrimeDay: ")
	isPrimeDay()
	
	#isFriday
	print("\n")
	print("isFriday: ")
	isFriday()
	
	sleep(10)
	
	#englishToOtherLangs()	
	#print("\n")
	println("Let's check what 'Germany' is in German!")
	@time begin
		t2 = englishToOtherLangs()
	end

	
	#displayImage	
	#Takes ~5-6 seconds
	@time begin
		t = displayImage()
	end
end

main()










