$PBExportHeader$w_int_etiquetas_ean_13.srw
$PBExportComments$Etiquetas EAN 13
forward
global type w_int_etiquetas_ean_13 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_etiquetas_ean_13
end type
type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_ean_13
end type
type uo_ean13 from u_em_campo_2 within w_int_etiquetas_ean_13
end type
type st_4 from statictext within w_int_etiquetas_ean_13
end type
type gb_3 from groupbox within w_int_etiquetas_ean_13
end type
type gb_1 from groupbox within w_int_etiquetas_ean_13
end type
type em_etiquetas from u_em_campo within w_int_etiquetas_ean_13
end type
type st_5 from statictext within w_int_etiquetas_ean_13
end type
type em_tono from u_em_campo within w_int_etiquetas_ean_13
end type
type st_6 from statictext within w_int_etiquetas_ean_13
end type
type st_333 from statictext within w_int_etiquetas_ean_13
end type
type uo_caja from u_em_campo_2 within w_int_etiquetas_ean_13
end type
type uo_formato from u_em_campo_2 within w_int_etiquetas_ean_13
end type
type st_555 from statictext within w_int_etiquetas_ean_13
end type
type st_455 from statictext within w_int_etiquetas_ean_13
end type
type st_666 from statictext within w_int_etiquetas_ean_13
end type
type uo_articulo from u_em_campo_2 within w_int_etiquetas_ean_13
end type
type em_pzcj from u_em_campo within w_int_etiquetas_ean_13
end type
type st_777 from statictext within w_int_etiquetas_ean_13
end type
type uo_texto1 from u_em_campo_2 within w_int_etiquetas_ean_13
end type
type uo_texto2 from u_em_campo_2 within w_int_etiquetas_ean_13
end type
type uo_texto3 from u_em_campo_2 within w_int_etiquetas_ean_13
end type
type uo_texto4 from u_em_campo_2 within w_int_etiquetas_ean_13
end type
type st_556 from statictext within w_int_etiquetas_ean_13
end type
type st_557 from statictext within w_int_etiquetas_ean_13
end type
type st_558 from statictext within w_int_etiquetas_ean_13
end type
type st_559 from statictext within w_int_etiquetas_ean_13
end type
type gb_2 from groupbox within w_int_etiquetas_ean_13
end type
type uo_idioma from u_em_campo_2 within w_int_etiquetas_ean_13
end type
type uo_cliente from u_em_campo_2 within w_int_etiquetas_ean_13
end type
type st_10 from statictext within w_int_etiquetas_ean_13
end type
type st_alt from statictext within w_int_etiquetas_ean_13
end type
type cbx_ean from checkbox within w_int_etiquetas_ean_13
end type
type cbx_rec from checkbox within w_int_etiquetas_ean_13
end type
type cbx_gran from checkbox within w_int_etiquetas_ean_13
end type
type em_cajascj from u_em_campo within w_int_etiquetas_ean_13
end type
type st_888 from statictext within w_int_etiquetas_ean_13
end type
type em_etiquetas2 from u_em_campo within w_int_etiquetas_ean_13
end type
type st_999 from statictext within w_int_etiquetas_ean_13
end type
type cb_1 from commandbutton within w_int_etiquetas_ean_13
end type
type dw_ean128 from datawindow within w_int_etiquetas_ean_13
end type
end forward

global type w_int_etiquetas_ean_13 from w_int_con_empresa
integer width = 5637
integer height = 1860
pb_1 pb_1
pb_imprimir_etiquetas pb_imprimir_etiquetas
uo_ean13 uo_ean13
st_4 st_4
gb_3 gb_3
gb_1 gb_1
em_etiquetas em_etiquetas
st_5 st_5
em_tono em_tono
st_6 st_6
st_333 st_333
uo_caja uo_caja
uo_formato uo_formato
st_555 st_555
st_455 st_455
st_666 st_666
uo_articulo uo_articulo
em_pzcj em_pzcj
st_777 st_777
uo_texto1 uo_texto1
uo_texto2 uo_texto2
uo_texto3 uo_texto3
uo_texto4 uo_texto4
st_556 st_556
st_557 st_557
st_558 st_558
st_559 st_559
gb_2 gb_2
uo_idioma uo_idioma
uo_cliente uo_cliente
st_10 st_10
st_alt st_alt
cbx_ean cbx_ean
cbx_rec cbx_rec
cbx_gran cbx_gran
em_cajascj em_cajascj
st_888 st_888
em_etiquetas2 em_etiquetas2
st_999 st_999
cb_1 cb_1
dw_ean128 dw_ean128
end type
global w_int_etiquetas_ean_13 w_int_etiquetas_ean_13

type variables
String var_zoom
end variables

forward prototypes
public subroutine f_desactivar (boolean bool)
end prototypes

public subroutine f_desactivar (boolean bool);uo_cliente.enabled   = bool
uo_articulo.enabled  = bool
uo_ean13.enabled     = bool
em_tono.enabled      = bool
uo_caja.enabled      = bool
em_etiquetas.enabled = bool


end subroutine

event ue_listar;CALL Super::ue_listar


 



end event

event open;call super::open;istr_parametros.s_titulo_ventana="Listado etiquetas articulos EAN 13"
This.title=istr_parametros.s_titulo_ventana
f_desactivar(TRUE)
cbx_ean.checked = true
cbx_rec.checked = false
f_activar_campo(uo_cliente.em_campo)


end event

on w_int_etiquetas_ean_13.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir_etiquetas=create pb_imprimir_etiquetas
this.uo_ean13=create uo_ean13
this.st_4=create st_4
this.gb_3=create gb_3
this.gb_1=create gb_1
this.em_etiquetas=create em_etiquetas
this.st_5=create st_5
this.em_tono=create em_tono
this.st_6=create st_6
this.st_333=create st_333
this.uo_caja=create uo_caja
this.uo_formato=create uo_formato
this.st_555=create st_555
this.st_455=create st_455
this.st_666=create st_666
this.uo_articulo=create uo_articulo
this.em_pzcj=create em_pzcj
this.st_777=create st_777
this.uo_texto1=create uo_texto1
this.uo_texto2=create uo_texto2
this.uo_texto3=create uo_texto3
this.uo_texto4=create uo_texto4
this.st_556=create st_556
this.st_557=create st_557
this.st_558=create st_558
this.st_559=create st_559
this.gb_2=create gb_2
this.uo_idioma=create uo_idioma
this.uo_cliente=create uo_cliente
this.st_10=create st_10
this.st_alt=create st_alt
this.cbx_ean=create cbx_ean
this.cbx_rec=create cbx_rec
this.cbx_gran=create cbx_gran
this.em_cajascj=create em_cajascj
this.st_888=create st_888
this.em_etiquetas2=create em_etiquetas2
this.st_999=create st_999
this.cb_1=create cb_1
this.dw_ean128=create dw_ean128
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir_etiquetas
this.Control[iCurrent+3]=this.uo_ean13
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.gb_3
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.em_etiquetas
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.em_tono
this.Control[iCurrent+10]=this.st_6
this.Control[iCurrent+11]=this.st_333
this.Control[iCurrent+12]=this.uo_caja
this.Control[iCurrent+13]=this.uo_formato
this.Control[iCurrent+14]=this.st_555
this.Control[iCurrent+15]=this.st_455
this.Control[iCurrent+16]=this.st_666
this.Control[iCurrent+17]=this.uo_articulo
this.Control[iCurrent+18]=this.em_pzcj
this.Control[iCurrent+19]=this.st_777
this.Control[iCurrent+20]=this.uo_texto1
this.Control[iCurrent+21]=this.uo_texto2
this.Control[iCurrent+22]=this.uo_texto3
this.Control[iCurrent+23]=this.uo_texto4
this.Control[iCurrent+24]=this.st_556
this.Control[iCurrent+25]=this.st_557
this.Control[iCurrent+26]=this.st_558
this.Control[iCurrent+27]=this.st_559
this.Control[iCurrent+28]=this.gb_2
this.Control[iCurrent+29]=this.uo_idioma
this.Control[iCurrent+30]=this.uo_cliente
this.Control[iCurrent+31]=this.st_10
this.Control[iCurrent+32]=this.st_alt
this.Control[iCurrent+33]=this.cbx_ean
this.Control[iCurrent+34]=this.cbx_rec
this.Control[iCurrent+35]=this.cbx_gran
this.Control[iCurrent+36]=this.em_cajascj
this.Control[iCurrent+37]=this.st_888
this.Control[iCurrent+38]=this.em_etiquetas2
this.Control[iCurrent+39]=this.st_999
this.Control[iCurrent+40]=this.cb_1
this.Control[iCurrent+41]=this.dw_ean128
end on

on w_int_etiquetas_ean_13.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir_etiquetas)
destroy(this.uo_ean13)
destroy(this.st_4)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.em_etiquetas)
destroy(this.st_5)
destroy(this.em_tono)
destroy(this.st_6)
destroy(this.st_333)
destroy(this.uo_caja)
destroy(this.uo_formato)
destroy(this.st_555)
destroy(this.st_455)
destroy(this.st_666)
destroy(this.uo_articulo)
destroy(this.em_pzcj)
destroy(this.st_777)
destroy(this.uo_texto1)
destroy(this.uo_texto2)
destroy(this.uo_texto3)
destroy(this.uo_texto4)
destroy(this.st_556)
destroy(this.st_557)
destroy(this.st_558)
destroy(this.st_559)
destroy(this.gb_2)
destroy(this.uo_idioma)
destroy(this.uo_cliente)
destroy(this.st_10)
destroy(this.st_alt)
destroy(this.cbx_ean)
destroy(this.cbx_rec)
destroy(this.cbx_gran)
destroy(this.em_cajascj)
destroy(this.st_888)
destroy(this.em_etiquetas2)
destroy(this.st_999)
destroy(this.cb_1)
destroy(this.dw_ean128)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_etiquetas_ean_13
integer x = 1765
integer y = 1384
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_etiquetas_ean_13
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_etiquetas_ean_13
integer x = 32
integer y = 24
integer width = 2757
integer height = 108
end type

type pb_1 from upb_salir within w_int_etiquetas_ean_13
integer x = 2848
integer y = 24
integer height = 108
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_ean_13
integer x = 2830
integer y = 1528
integer width = 123
integer height = 104
integer taborder = 190
string picturename = "c:\bmp\print.bmp"
end type

event clicked;string etiqueta
long   trabajo,longi

if trim(em_etiquetas.text) = "0" and trim(em_etiquetas2.text) = "0" then
	messagebox("Advertencia","No se ha introducido la cantidad de etiquetas")
	f_activar_campo(em_etiquetas)
	return
end if

if isnull(uo_cliente.em_campo.text) or trim(uo_cliente.em_campo.text) = "" then
	messagebox("Advertencia","No se ha introducido el cliente")
	f_activar_campo(uo_cliente.em_campo)
	return
end if

if isnull(uo_articulo.em_campo.text) or trim(uo_articulo.em_campo.text) = "" then
	messagebox("Advertencia","No se ha introducido el articulo")
	f_activar_campo(uo_articulo.em_campo)
	return
else
	longi = len(trim(uo_articulo.em_campo.text))
end if

if isnull(uo_ean13.em_campo.text) or trim(uo_ean13.em_campo.text) = "" then
	messagebox("Advertencia","No se ha introducido el EAN 13")
	f_activar_campo(uo_ean13.em_campo)
	return
end if

if isnull(em_tono.text) or trim(em_tono.text) = "" then
	messagebox("Advertencia","No se ha introducido el tono")
	f_activar_campo(em_tono)
	return
end if

if isnull(uo_caja.em_campo.text) or trim(uo_caja.em_campo.text) = "" then
	messagebox("Advertencia","No se ha introducido el tipo de caja")
	f_activar_campo(uo_caja.em_campo)
	return
end if

if cbx_ean.checked then
	etiqueta =   "^xa"
	if uo_cliente.em_codigo.text = "79" then
		if len(trim(uo_texto4.em_campo.text))<> 0 then
			etiqueta = etiqueta + "^fo40,35^a0n30,30^fd"+trim(uo_texto4.em_campo.text)+"^fs"
			etiqueta = etiqueta + "^fo70,67^BY4,,^BEn,100,y,n,^fd"+trim(uo_ean13.em_campo.text)+"^fs"
			etiqueta = etiqueta + "^fo40,202^a0n30,30^fd"+trim(uo_texto1.em_campo.text)+"   "+trim(uo_formato.em_campo.text)+" CM."+"^fs"
			etiqueta = etiqueta + "^fo40,232^a0n30,30^fdDESIGN : "+trim(uo_texto3.em_campo.text)+"^fs"
			etiqueta = etiqueta + "^fo40,262^a0n30,30^fdFARBE  : "+trim(uo_texto2.em_campo.text)+"^fs"
		else
			if longi <= 25 then
				etiqueta = etiqueta + "^fo40,35^a0n35,35^fd"+trim(uo_articulo.em_campo.text)+"^fs"
			else
				etiqueta = etiqueta + "^fo40,35^a0n25,25^fd"+trim(uo_articulo.em_campo.text)+"^fs"
			end if
			etiqueta = etiqueta + "^fo40,76^a0n35,35^fd"+trim(uo_formato.em_campo.text)+" CM.     "+trim(em_pzcj.text)+" STK."+"^fs"
			etiqueta = etiqueta + "^fo40,116^a0n35,35^fdTONO ("+trim(em_tono.text)+")^fs"
			etiqueta = etiqueta + "^fo70,155^BY4,,^BEn,100,y,n,^fd"+trim(uo_ean13.em_campo.text)+"^fs"
		end if
	else
		etiqueta = etiqueta + "^fo40,35^a0n35,35^fd"+trim(uo_texto1.em_campo.text)+" "+trim(uo_texto2.em_campo.text)+"^fs"
		etiqueta = etiqueta + "^fo40,76^a0n35,35^fd"+trim(uo_formato.em_campo.text)+" CM.     "+trim(em_pzcj.text)+" STK."+"^fs"
		etiqueta = etiqueta + "^fo40,116^a0n35,35^fdSERIE:    "+trim(uo_texto3.em_campo.text)+"^fs"
		etiqueta = etiqueta + "^fo70,155^BY4,,^BEn,100,y,n,^fd"+trim(uo_ean13.em_campo.text)+"^fs"
	end if
	etiqueta = etiqueta +"^pq"+em_etiquetas.text+"^fs^xz"
	
	trabajo = FileOpen('LPT1:',LineMode!,Write!)
	FileWrite(trabajo,etiqueta)
	FileClose(trabajo)
end if

etiqueta = ""
if cbx_rec.checked then
	if uo_cliente.em_codigo.text = "79" and len(trim(uo_texto4.em_campo.text))<> 0 then
			etiqueta = "^XA"
			etiqueta = etiqueta + "^CT+"
			etiqueta = etiqueta + "+DGR:REC,00282,006,"
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000002000000" 
			etiqueta = etiqueta + "000003020000" 
			etiqueta = etiqueta + "000003C10000" 
			etiqueta = etiqueta + "000003E08000" 
			etiqueta = etiqueta + "00001FF04000" 
			etiqueta = etiqueta + "00007FF86000" 
			etiqueta = etiqueta + "0001FFFC3000" 
			etiqueta = etiqueta + "0003FFFE3000" 
			etiqueta = etiqueta + "0007FFFE3800" 
			etiqueta = etiqueta + "000FFFFC1800" 
			etiqueta = etiqueta + "001FFFF81C00" 
			etiqueta = etiqueta + "001FFFF01C00" 
			etiqueta = etiqueta + "003FFFE03C00" 
			etiqueta = etiqueta + "003FFBC03C00" 
			etiqueta = etiqueta + "003FF3803C00" 
			etiqueta = etiqueta + "003FE3007C00"
			etiqueta = etiqueta + "003FC2007C00" 
			etiqueta = etiqueta + "003F8000F800" 
			etiqueta = etiqueta + "003F0000F800" 
			etiqueta = etiqueta + "003E0001F000" 
			etiqueta = etiqueta + "001F0003F000" 
			etiqueta = etiqueta + "001F800FE000" 
			etiqueta = etiqueta + "000FC07FE000" 
			etiqueta = etiqueta + "000FE3FFC000" 
			etiqueta = etiqueta + "0007F3FF8000" 
			etiqueta = etiqueta + "0003FBFF0000" 
			etiqueta = etiqueta + "0000FFFE0000" 
			etiqueta = etiqueta + "00003FF80000" 
			etiqueta = etiqueta + "00000FE00000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000"
 			etiqueta = etiqueta + "^FO330,50^A0N20,20^FDDER GRUNE PUNKT^FS"
			etiqueta = etiqueta + "^FO350,60^XGR:REC,2,2^FS"
			etiqueta = etiqueta + "^FO40,130^A0N40,40^FD"+trim(uo_texto1.em_campo.text)+"^FS"
			etiqueta = etiqueta + "^FO40,200^A0N30,30^FDFormat : "+string(f_nombre_formato_parte1(codigo_empresa,uo_formato.em_codigo.text),"#0.#0")+" / "+string(f_nombre_formato_parte2(codigo_empresa,uo_formato.em_codigo.text),"#0.#0")+" cm.^FS"
			etiqueta = etiqueta + "^FO40,240^A0N30,30^FDInhalt : "+trim(em_pzcj.text)+" stk.^FS"
			etiqueta = etiqueta + "^PQ"+em_etiquetas.text+"^FS^XZ"
			
			trabajo = FileOpen('LPT1:',LineMode!,Write!)
			FileWrite(trabajo,etiqueta)
			FileClose(trabajo)
	end if
end if

etiqueta = ""
if cbx_gran.checked then
	if uo_cliente.em_codigo.text = "79" and dec(em_cajascj.text)<> 0 then
			etiqueta = "^XA"
			etiqueta = etiqueta + "^CT+"
			etiqueta = etiqueta + "+DGR:REC,00282,006,"
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000002000000" 
			etiqueta = etiqueta + "000003020000" 
			etiqueta = etiqueta + "000003C10000" 
			etiqueta = etiqueta + "000003E08000" 
			etiqueta = etiqueta + "00001FF04000" 
			etiqueta = etiqueta + "00007FF86000" 
			etiqueta = etiqueta + "0001FFFC3000" 
			etiqueta = etiqueta + "0003FFFE3000" 
			etiqueta = etiqueta + "0007FFFE3800" 
			etiqueta = etiqueta + "000FFFFC1800" 
			etiqueta = etiqueta + "001FFFF81C00" 
			etiqueta = etiqueta + "001FFFF01C00" 
			etiqueta = etiqueta + "003FFFE03C00" 
			etiqueta = etiqueta + "003FFBC03C00" 
			etiqueta = etiqueta + "003FF3803C00" 
			etiqueta = etiqueta + "003FE3007C00"
			etiqueta = etiqueta + "003FC2007C00" 
			etiqueta = etiqueta + "003F8000F800" 
			etiqueta = etiqueta + "003F0000F800" 
			etiqueta = etiqueta + "003E0001F000" 
			etiqueta = etiqueta + "001F0003F000" 
			etiqueta = etiqueta + "001F800FE000" 
			etiqueta = etiqueta + "000FC07FE000" 
			etiqueta = etiqueta + "000FE3FFC000" 
			etiqueta = etiqueta + "0007F3FF8000" 
			etiqueta = etiqueta + "0003FBFF0000" 
			etiqueta = etiqueta + "0000FFFE0000" 
			etiqueta = etiqueta + "00003FF80000" 
			etiqueta = etiqueta + "00000FE00000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000" 
			etiqueta = etiqueta + "000000000000"
 			etiqueta = etiqueta + "^FO330,50^A0N20,20^FDDER GRUNE PUNKT^FS"
			etiqueta = etiqueta + "^FO350,60^XGR:REC,2,2^FS"
			etiqueta = etiqueta + "^FO40,80^A0N40,40^FD"+trim(uo_texto1.em_campo.text)+"^FS"
			etiqueta = etiqueta + "^FO40,150^A0N40,40^FD"+"Inhalt Umkarton : "+trim(em_cajascj.text)+" Boxes^FS"
			etiqueta = etiqueta + "^FO40,200^A0N30,30^FDFormat : "+string(f_nombre_formato_parte1(codigo_empresa,uo_formato.em_codigo.text),"#0.#0")+" / "+string(f_nombre_formato_parte2(codigo_empresa,uo_formato.em_codigo.text),"#0.#0")+" cm.^FS"
			etiqueta = etiqueta + "^FO40,240^A0N30,30^FDInhalt : "+trim(em_pzcj.text)+" stk.^FS"
			etiqueta = etiqueta + "^PQ"+em_etiquetas2.text+"^FS^XZ"
			
			trabajo = FileOpen('LPT1:',LineMode!,Write!)
			FileWrite(trabajo,etiqueta)
			FileClose(trabajo)
	end if
end if

f_activar_campo(uo_cliente.em_campo)

end event

type uo_ean13 from u_em_campo_2 within w_int_etiquetas_ean_13
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 553
integer y = 620
integer width = 754
integer height = 88
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)

IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
 Return
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""


end event

on uo_ean13.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_int_etiquetas_ean_13
integer x = 1074
integer y = 1284
integer width = 402
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Etiquetas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_int_etiquetas_ean_13
integer x = 1495
integer y = 1436
integer width = 1289
integer height = 204
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo"
end type

type gb_1 from groupbox within w_int_etiquetas_ean_13
integer x = 2811
integer y = 1480
integer width = 151
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type em_etiquetas from u_em_campo within w_int_etiquetas_ean_13
integer x = 1074
integer y = 1360
integer width = 402
integer height = 88
integer taborder = 140
string text = "0"
alignment alignment = right!
string mask = "xxxxx"
end type

event modificado;call super::modificado;if dec(em_cajascj.text) <> 0 then
	em_etiquetas2.text = string(round(dec(em_etiquetas.text)/dec(em_cajascj.text),0),"###,###")
end if
end event

type st_5 from statictext within w_int_etiquetas_ean_13
integer x = 55
integer y = 1284
integer width = 283
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tono"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_tono from u_em_campo within w_int_etiquetas_ean_13
integer x = 55
integer y = 1360
integer width = 279
integer height = 88
integer taborder = 110
string text = "0"
alignment alignment = right!
end type

type st_6 from statictext within w_int_etiquetas_ean_13
integer x = 1728
integer y = 348
integer width = 251
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Idioma"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_333 from statictext within w_int_etiquetas_ean_13
integer x = 338
integer y = 1284
integer width = 448
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Caja"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_caja from u_em_campo_2 within w_int_etiquetas_ean_13
event destroy ( )
integer x = 338
integer y = 1360
integer width = 443
integer height = 88
integer taborder = 120
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_caja.em_campo.text=f_nombre_caja(codigo_empresa,uo_caja.em_codigo.text)
em_pzcj.text = string(f_piezascaja_articulo(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text))
IF Trim(uo_caja.em_campo.text)="" THEN 
 IF Trim(uo_caja.em_codigo.text)<>"" Then uo_caja.em_campo.SetFocus()
 uo_caja.em_campo.text=""
 uo_caja.em_codigo.text=""
 Return
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_almartcajas"
ue_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"


end event

type uo_formato from u_em_campo_2 within w_int_etiquetas_ean_13
event destroy ( )
integer x = 41
integer y = 620
integer width = 503
integer height = 88
integer taborder = 50
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

type st_555 from statictext within w_int_etiquetas_ean_13
integer x = 553
integer y = 540
integer width = 754
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "EAN 13"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_455 from statictext within w_int_etiquetas_ean_13
integer x = 41
integer y = 540
integer width = 507
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Formato"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_666 from statictext within w_int_etiquetas_ean_13
integer x = 37
integer y = 348
integer width = 1678
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_int_etiquetas_ean_13
event destroy ( )
integer x = 37
integer y = 428
integer width = 1678
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;Long total_desc

uo_articulo.em_campo.text=f_descripcion_almcliartdesc2(codigo_empresa,uo_cliente.em_codigo.text,uo_articulo.em_codigo.text,dec(uo_idioma.em_codigo.text))
IF Trim(uo_articulo.em_campo.text)="" THEN 
   uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
END IF

select count(descripcion)
into :total_desc
from almcliartdesc
where empresa=:codigo_empresa and
		cliente=:uo_cliente.em_codigo.text and
		articulo=:uo_articulo.em_codigo.text
group by empresa,cliente,articulo;

if isnull(total_desc) then total_desc = 0

if total_desc >= 1 then
	uo_idioma.em_codigo.text = "1"
	uo_idioma.em_campo.text  = "1"
else
	uo_idioma.em_codigo.text = "0"
	uo_idioma.em_campo.text  = "0"
end if
uo_idioma.TriggerEvent("modificado")

uo_formato.em_campo.text  =f_nombre_formato(codigo_empresa,f_formato_articulo(codigo_empresa,uo_articulo.em_codigo.text))
uo_formato.em_codigo.text =f_formato_articulo(codigo_empresa,uo_articulo.em_codigo.text)
uo_ean13.em_campo.text    =f_nombre_ean13(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,dec(uo_idioma.em_codigo.text))
em_cajascj.text           =string(f_cajas_caja(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,dec(uo_idioma.em_codigo.text)),"###,###")
uo_texto1.em_campo.text   =f_nombre_texto_ean13(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,1,dec(uo_idioma.em_codigo.text))
uo_texto2.em_campo.text   =f_nombre_texto_ean13(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,2,dec(uo_idioma.em_codigo.text))
uo_texto3.em_campo.text   =f_nombre_texto_ean13(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,3,dec(uo_idioma.em_codigo.text))
uo_texto4.em_campo.text   =f_nombre_texto_ean13(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,4,dec(uo_idioma.em_codigo.text))
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
 Return
END IF

end event

event getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos_almcliartdesc"
ue_filtro     = ""


end event

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type em_pzcj from u_em_campo within w_int_etiquetas_ean_13
integer x = 786
integer y = 1360
integer width = 283
integer height = 88
integer taborder = 130
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

type st_777 from statictext within w_int_etiquetas_ean_13
integer x = 786
integer y = 1284
integer width = 288
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pz./Cj."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_texto1 from u_em_campo_2 within w_int_etiquetas_ean_13
event destroy ( )
integer x = 585
integer y = 908
integer width = 1321
integer height = 88
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_texto1.destroy
call u_em_campo_2::destroy
end on

type uo_texto2 from u_em_campo_2 within w_int_etiquetas_ean_13
event destroy ( )
integer x = 585
integer y = 1008
integer width = 1321
integer height = 88
integer taborder = 90
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_texto2.destroy
call u_em_campo_2::destroy
end on

type uo_texto3 from u_em_campo_2 within w_int_etiquetas_ean_13
event destroy ( )
integer x = 585
integer y = 1112
integer width = 1321
integer height = 88
integer taborder = 100
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_texto3.destroy
call u_em_campo_2::destroy
end on

type uo_texto4 from u_em_campo_2 within w_int_etiquetas_ean_13
event destroy ( )
integer x = 585
integer y = 800
integer width = 1321
integer height = 88
integer taborder = 70
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_texto4.destroy
call u_em_campo_2::destroy
end on

type st_556 from statictext within w_int_etiquetas_ean_13
integer x = 73
integer y = 908
integer width = 503
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nombre"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_557 from statictext within w_int_etiquetas_ean_13
integer x = 73
integer y = 1008
integer width = 503
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Color"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_558 from statictext within w_int_etiquetas_ean_13
integer x = 73
integer y = 1112
integer width = 503
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Serie"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_559 from statictext within w_int_etiquetas_ean_13
integer x = 73
integer y = 804
integer width = 503
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cabecera"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_int_etiquetas_ean_13
integer x = 37
integer y = 724
integer width = 1925
integer height = 520
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Etiqueta Texto Alternativo"
end type

type uo_idioma from u_em_campo_2 within w_int_etiquetas_ean_13
event destroy ( )
integer x = 1728
integer y = 428
integer width = 251
integer height = 88
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_idioma.destroy
call u_em_campo_2::destroy
end on

event modificado;if uo_idioma.em_codigo.text = "0" then
	st_alt.text="SIN DESCRIPCIÓN ALTERNATIVA"	
else
	st_alt.text="CON DESCRIPCIÓN ALTERNATIVA"
	uo_idioma.em_campo.text = uo_idioma.em_codigo.text
	uo_articulo.em_campo.text=f_descripcion_almcliartdesc2(codigo_empresa,uo_cliente.em_codigo.text,uo_articulo.em_codigo.text,dec(uo_idioma.em_codigo.text))
	uo_formato.em_campo.text  =f_nombre_formato(codigo_empresa,f_formato_articulo(codigo_empresa,uo_articulo.em_codigo.text))
	uo_ean13.em_campo.text    =f_nombre_ean13(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,dec(uo_idioma.em_codigo.text))
	em_cajascj.text           =string(f_cajas_caja(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,dec(uo_idioma.em_codigo.text)),"###,###")
	uo_texto1.em_campo.text   =f_nombre_texto_ean13(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,1,dec(uo_idioma.em_codigo.text))
	uo_texto2.em_campo.text   =f_nombre_texto_ean13(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,2,dec(uo_idioma.em_codigo.text))
	uo_texto3.em_campo.text   =f_nombre_texto_ean13(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,3,dec(uo_idioma.em_codigo.text))
	uo_texto4.em_campo.text   =f_nombre_texto_ean13(codigo_empresa,uo_articulo.em_codigo.text,uo_cliente.em_codigo.text,4,dec(uo_idioma.em_codigo.text))
end if
IF Trim(st_alt.text)="" THEN 
 IF Trim(uo_idioma.em_codigo.text)<>"" Then  f_activar_campo(uo_idioma.em_codigo)
 uo_idioma.em_codigo.text=""
END IF
end event

event getfocus;valor_empresa = TRUE
ue_titulo     = "Ayuda seleccion de descripciones alternativas"
ue_datawindow = "dw_ayuda_almcliartdesc"
ue_filtro     = "cliente = '"+uo_cliente.em_codigo.text+"' and codigo = '"+uo_articulo.em_codigo.text+"'"

end event

type uo_cliente from u_em_campo_2 within w_int_etiquetas_ean_13
event destroy ( )
integer x = 37
integer y = 236
integer width = 1687
integer height = 88
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
IF Trim(uo_cliente.em_campo.text)="" THEN 
 IF Trim(uo_cliente.em_codigo.text)<>"" Then uo_cliente.em_campo.SetFocus()
 uo_cliente.em_campo.text=""
 uo_cliente.em_codigo.text=""
 Return
END IF

end event

event getfocus;ue_titulo     = "Ayuda seleccion de clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""


end event

type st_10 from statictext within w_int_etiquetas_ean_13
integer x = 37
integer y = 160
integer width = 1682
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_alt from statictext within w_int_etiquetas_ean_13
integer x = 1993
integer y = 428
integer width = 1015
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cbx_ean from checkbox within w_int_etiquetas_ean_13
integer x = 1527
integer y = 1520
integer width = 283
integer height = 76
integer taborder = 170
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "EAN 13"
end type

type cbx_rec from checkbox within w_int_etiquetas_ean_13
integer x = 1847
integer y = 1520
integer width = 352
integer height = 76
integer taborder = 180
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Reciclaje"
end type

type cbx_gran from checkbox within w_int_etiquetas_ean_13
integer x = 2249
integer y = 1520
integer width = 521
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cajas Grandes"
end type

type em_cajascj from u_em_campo within w_int_etiquetas_ean_13
integer x = 786
integer y = 1544
integer width = 283
integer height = 88
integer taborder = 150
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

event modificado;call super::modificado;if dec(em_cajascj.text) <> 0 then
	em_etiquetas2.text = string(round(dec(em_etiquetas.text)/dec(em_cajascj.text),0),"###,###")
end if
end event

type st_888 from statictext within w_int_etiquetas_ean_13
integer x = 786
integer y = 1472
integer width = 288
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cajas/Cj."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_etiquetas2 from u_em_campo within w_int_etiquetas_ean_13
integer x = 1074
integer y = 1544
integer width = 402
integer height = 88
integer taborder = 160
string text = "0"
alignment alignment = right!
string mask = "xxxxx"
end type

type st_999 from statictext within w_int_etiquetas_ean_13
integer x = 1074
integer y = 1472
integer width = 402
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Eti.Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_int_etiquetas_ean_13
integer x = 1445
integer y = 584
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "EAN 128"
end type

event clicked;//
// Initialize running total with value of start character, then scan the
// string and add character value times position
//
long SUBTOT,INDICE,VALOR,CHKDIG
string OUTSTRING,MYSTRING,C,CHKCHR

MYSTRING = "084352599000000344"//"(01)02003659821451(10)0001(30)25(91)1(92)5" //"(01)02003659821451(10)1200(92)5(91)ABCD"

SUBTOT = 104
FOR INDICE = 1 TO LEN(MYSTRING)
	 C = MID(MYSTRING, INDICE, 1)
	 VALOR = ASC(C) - 32
	 SUBTOT = SUBTOT + (VALOR * INDICE)
NEXT
//
// Calculate Modulo 103. This is the checksum
//
CHKDIG = MOD(SUBTOT, 103)
//
// Now convert numeric checksum to a character. This conversion takes
// into account the particular mapping of the font being used (this
// example is for the font published by Azalea Software).

IF CHKDIG = 0 THEN
	CHKCHR = CHAR(174)
ELSE
	IF CHKDIG < 94 THEN
		CHKCHR = CHAR(CHKDIG + 32)
	ELSE
		CHKCHR = CHAR(CHKDIG + 71)
	END IF	
END IF
//
// Now format the final output string: start character,
// data, check character, and stop character.
//
OUTSTRING = CHAR(204) + MYSTRING + CHKCHR + CHAR(206)

long ll_control,ll_donde

dw_ean128.reset()

for ll_control = 32 to 255
//
	OUTSTRING = CHAR(ll_control) //+ MYSTRING + CHKCHR + CHAR(ll_control+2)
	
	ll_donde = dw_ean128.insertrow(0)
	dw_ean128.object.ean128[ll_donde] = OUTSTRING
	dw_ean128.object.ean128_texto[ll_donde] = MYSTRING
	
next	

dw_ean128.print(false)
end event

type dw_ean128 from datawindow within w_int_etiquetas_ean_13
integer x = 1993
integer y = 584
integer width = 3611
integer height = 672
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_etiqueta_ean128"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

