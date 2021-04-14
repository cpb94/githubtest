$PBExportHeader$u_dw_imagen.sru
forward
global type u_dw_imagen from datawindow
end type
end forward

global type u_dw_imagen from datawindow
integer width = 686
integer height = 400
string title = "Imagen"
string dataobject = "dw_aux_imagen"
boolean border = false
end type
global u_dw_imagen u_dw_imagen

on u_dw_imagen.create
end on

on u_dw_imagen.destroy
end on

event rbuttondown;string ruta, pathname, ruta_destino
string filename[]
int res

ruta = this.Object.datawindow.picture.File

if not isnull(ruta) and ruta <> "" then
	ContextKeyword lcxk_base
	this.GetContextService("Keyword", lcxk_base)
	ruta_destino = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop"
	res = GetFileSaveName ("Descargar Archivo", pathname, filename, "jpg", "Imagenes jpg,*.jpg", ruta_destino, 2)
	if res = 1 then
		if fileexists(pathname) then
			res = MessageBox("El archivo ya existe", "¿Desea reemplazar el fichero existente en el disco?",Question!,YesNo!,2)
		end if
		if res = 1 then
			res = FileCopy(ruta, pathname, true)
			if res = -1 then
				MessageBox("Error", "Error de lectura de la imagen.")
			elseif res = -2 then
				MessageBox("Error", "Error de escritura de la imagen.")
			else 
				//run("rundll32.exe C:\WINDOWS\system32\shimgvw.dll,ImageView_Fullscreen "+pathname) //Muestra la imagen - equivalente a explorer + pathname
				run("explorer "+f_reemplazar(pathname,filename[1],"")) //Muestra la carpeta
			end if
		end if
	else
		MessageBox("Error", "No ha sido posible guardar en la ruta indicada.")
	end if
else
	MessageBox("Error", "No existe imagen para descargar o la imagen seleccionada todabía no ha sido guardada.")
end if
end event

