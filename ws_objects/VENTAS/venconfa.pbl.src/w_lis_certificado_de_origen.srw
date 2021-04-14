$PBExportHeader$w_lis_certificado_de_origen.srw
forward
global type w_lis_certificado_de_origen from w_int_con_empresa
end type
type pb_1 from upb_salir within w_lis_certificado_de_origen
end type
type st_2 from statictext within w_lis_certificado_de_origen
end type
type em_anyo from u_em_campo within w_lis_certificado_de_origen
end type
type em_factura from u_em_campo within w_lis_certificado_de_origen
end type
type st_3 from statictext within w_lis_certificado_de_origen
end type
type cb_2 from u_boton within w_lis_certificado_de_origen
end type
type cb_1 from u_boton within w_lis_certificado_de_origen
end type
type st_cliente from statictext within w_lis_certificado_de_origen
end type
type st_codcli from statictext within w_lis_certificado_de_origen
end type
type gb_2 from groupbox within w_lis_certificado_de_origen
end type
type gb_3 from groupbox within w_lis_certificado_de_origen
end type
type dw_preliminar from datawindow within w_lis_certificado_de_origen
end type
type dw_listado from datawindow within w_lis_certificado_de_origen
end type
type dw_bandas from datawindow within w_lis_certificado_de_origen
end type
type st_1 from statictext within w_lis_certificado_de_origen
end type
type pb_imprimir from picturebutton within w_lis_certificado_de_origen
end type
type gb_1 from groupbox within w_lis_certificado_de_origen
end type
type pb_borrar from picturebutton within w_lis_certificado_de_origen
end type
end forward

global type w_lis_certificado_de_origen from w_int_con_empresa
integer width = 2903
integer height = 1688
pb_1 pb_1
st_2 st_2
em_anyo em_anyo
em_factura em_factura
st_3 st_3
cb_2 cb_2
cb_1 cb_1
st_cliente st_cliente
st_codcli st_codcli
gb_2 gb_2
gb_3 gb_3
dw_preliminar dw_preliminar
dw_listado dw_listado
dw_bandas dw_bandas
st_1 st_1
pb_imprimir pb_imprimir
gb_1 gb_1
pb_borrar pb_borrar
end type
global w_lis_certificado_de_origen w_lis_certificado_de_origen

type variables
boolean existe
string var_idioma,var_moneda,var_codcli

end variables

forward prototypes
public subroutine f_crear ()
public subroutine f_recuperar ()
public subroutine f_grabar ()
end prototypes

public subroutine f_crear ();string etiqueta_empresa
long indice,total,indice_expedidor,anyo,factura
string expedidor[1 to 5],destinatario[1 to 5],observaciones[1 to 5],cantidad[1 to 5]
string cl_domicilio,domicilio,nu_domicilio,codpostal,ciudad
string pais,provincia,apto_correos,prefijo_provincia,telefono
string fax,internet,cif,compuesto
string idioma,serie

dw_preliminar.Retrieve(codigo_empresa)
dw_listado.Retrieve(codigo_empresa)
anyo    = dec(em_anyo.text)
factura = dec(em_factura.text)
idioma  = f_idioma_venfac(codigo_empresa,anyo,factura)
serie   = f_serie_venfac(codigo_empresa,anyo,factura)
SELECT cl_domicilio,
       domicilio,
		 nu_domicilio,
		 codpostal,
		 ciudad,
		 pais,
		 provincia,
		 apto_correos,
		 prefijo_provincia,
		 telefono,
		 fax,
		 internet,
		 cif
INTO   :cl_domicilio,
       :domicilio,
		 :nu_domicilio,
		 :codpostal,
		 :ciudad,
		 :pais,
		 :provincia,
		 :apto_correos,
		 :prefijo_provincia,
		 :telefono,
		 :fax,
		 :internet,
		 :cif
FROM   empresas  
WHERE  empresas.empresa = :codigo_empresa;

if isnull(cl_domicilio) then cl_domicilio = ""
if isnull(domicilio) then domicilio = ""       
if isnull(nu_domicilio) then nu_domicilio = ""		 
if isnull(codpostal) then codpostal = ""		 
if isnull(ciudad) then ciudad = ""		 
if isnull(pais) then pais = ""		 
if isnull(provincia) then provincia = ""		 
if isnull(apto_correos) then apto_correos = ""		 
if isnull(prefijo_provincia) then prefijo_provincia = ""		 
if isnull(telefono) then telefono = ""		 
if isnull(fax) then fax = ""		 
if isnull(internet) then internet = ""		 
if isnull(cif) then cif = ""		 

expedidor[1] = f_nombre_empresa(codigo_empresa)
expedidor[2] = Trim(cl_domicilio) + "  " +Trim(domicilio) +  ", " +Trim(nu_domicilio)
expedidor[3] = codpostal + " " + ciudad + " - " + f_nombre_provincia(pais,provincia)  + " - " + f_nombre_pais(pais)+" "+ apto_correos
expedidor[4] = "Tel." + "("+ prefijo_provincia +") "+ telefono + " - Fax ("+ prefijo_provincia +") " + fax
expedidor[5] = "Internet: "+ internet 

//compuesto = compuesto + "VAT CEE: ES "+ cif +"~n"
destinatario[1] = f_razon_o_compuesto_cliente(codigo_empresa,st_codcli.text)
destinatario[2] = f_domicilio_genter(codigo_empresa,"C",st_codcli.text)
destinatario[3] = f_postal_genter(codigo_empresa,"C",st_codcli.text)+" "+f_localidad_genter(codigo_empresa,"C",st_codcli.text)
destinatario[4] = f_nombre_provincia(f_pais_genter(codigo_empresa,"C",st_codcli.text),f_provincia_genter(codigo_empresa,"C",st_codcli.text))
destinatario[5] = f_nombre_pais(f_pais_genter(codigo_empresa,"C",st_codcli.text))

if idioma = "1" then
	observaciones[1] = "Factura : " + f_nombre_venseries_abr(codigo_empresa,serie) +"-"+right(String(factura),4)
	observaciones[2] = f_nombre_carforpag(codigo_empresa,f_codpago_venfac(codigo_empresa,anyo,factura))
	pais             = f_nombre_pais(pais)
else
	observaciones[1] = f_diccionario("Factura",idioma)+" : "+f_nombre_venseries_abr(codigo_empresa,serie) +"-"+right(String(factura),4)
	observaciones[2] = f_nombre1_carforpagidioma(codigo_empresa,f_codpago_venfac(codigo_empresa,anyo,factura),idioma)
	pais             = f_diccionario(f_nombre_pais(pais),idioma)
end if

if idioma = "1" then
	cantidad[1] = "Peso Bruto :"
	cantidad[3] = "Peso  Neto :"
else
	cantidad[1] = f_diccionario("PESO BRUTO", idioma )+" :"
	cantidad[3] = f_diccionario("PESO NETO", idioma )+" :"
end if
cantidad[2] = "         "+string(f_peso_venfac(codigo_empresa,anyo,factura),"###,###,##0")+"  Kg"
cantidad[4] = "         "+string(f_peso_neto_venfac(codigo_empresa,anyo,factura),"###,###,##0")+"  Kg"

dw_preliminar.insertrow(1)
dw_preliminar.object.empresa[1]        = codigo_empresa
dw_preliminar.object.expedidor1[1]     = expedidor[1]
dw_preliminar.object.expedidor2[1]     = expedidor[2]
dw_preliminar.object.expedidor3[1]     = expedidor[3]
dw_preliminar.object.expedidor4[1]     = expedidor[4]
dw_preliminar.object.expedidor5[1]     = expedidor[5]
dw_preliminar.object.destinatario1[1]  = destinatario[1] 
dw_preliminar.object.destinatario2[1]  = destinatario[2] 
dw_preliminar.object.destinatario3[1]  = destinatario[3] 
dw_preliminar.object.destinatario4[1]  = destinatario[4] 
dw_preliminar.object.destinatario5[1]  = destinatario[5] 
dw_preliminar.object.pais_de_origen[1] = pais 
dw_preliminar.object.observaciones1[1] = observaciones[1] 
dw_preliminar.object.observaciones2[1] = observaciones[2] 
dw_preliminar.object.cantidad1[1]      = cantidad[1] 
dw_preliminar.object.cantidad2[1]      = cantidad[2] 
dw_preliminar.object.cantidad3[1]      = cantidad[3] 
dw_preliminar.object.cantidad4[1]      = cantidad[4] 

end subroutine

public subroutine f_recuperar ();string var_expedidor,var_destinatario,var_observaciones
string var_cantidad,var_designacion,var_pais
string expedidor[1 to 5],destinatario[1 to 5],observaciones[1 to 5]
string cantidad[1 to 9],designacion[1 to 15]
long anyo,factura,indice_array,indice,total

anyo    = dec(em_anyo.text)
factura = dec(em_factura.text)

select expedidor,
       destinatario,
		 observaciones,
		 cantidad,
		 designacion,
		 pais
into   :var_expedidor,
		 :var_destinatario,
		 :var_observaciones,
		 :var_cantidad,
		 :var_designacion,
		 :var_pais
from   vencertificado_origen
where  empresa = :codigo_empresa
and    anyo    = :anyo
and    factura = :factura;

var_expedidor     = trim(var_expedidor)
var_destinatario  = trim(var_destinatario)
var_observaciones = trim(var_observaciones)
var_cantidad      = trim(var_cantidad)
var_designacion   = trim(var_designacion)
var_pais          = trim(var_pais)

indice_array      = 1
total = len(var_expedidor)
for indice = 1 to total
	if mid(var_expedidor,indice,1) = char(13) then
		indice_array ++
	else
		expedidor[indice_array] = expedidor[indice_array] + mid(var_expedidor,indice,1)
	end if
next
indice_array      = 1
total = len(var_destinatario)
for indice = 1 to total
	if mid(var_destinatario,indice,1) = char(13) then
		indice_array ++
	else
		destinatario[indice_array] = destinatario[indice_array] + mid(var_destinatario,indice,1)
	end if
next
indice_array      = 1
total = len(var_observaciones)
for indice = 1 to total
	if mid(var_observaciones,indice,1) = char(13) then
		indice_array ++
	else
		observaciones[indice_array] = observaciones[indice_array] + mid(var_observaciones,indice,1)
	end if
next
indice_array      = 1
total = len(var_cantidad)
for indice = 1 to total
	if mid(var_cantidad,indice,1) = char(13) then
		indice_array ++
	else
		cantidad[indice_array] = cantidad[indice_array] + mid(var_cantidad,indice,1)
	end if
next
indice_array      = 1
total = len(var_designacion)
for indice = 1 to total
	if mid(var_designacion,indice,1) = char(13) then
		indice_array ++
	else
		designacion[indice_array] = designacion[indice_array] + mid(var_designacion,indice,1)
	end if
next
dw_preliminar.insertrow(1)
dw_preliminar.object.pais_de_origen[1] = var_pais

for indice = 1 to 5
	dw_preliminar.setitem(1,"expedidor"+string(indice,"#"),expedidor[indice])
	dw_preliminar.setitem(1,"destinatario"+string(indice,"#"),destinatario[indice])
	dw_preliminar.setitem(1,"observaciones"+string(indice,"#"),observaciones[indice])	
next
for indice = 1 to 9
	dw_preliminar.setitem(1,"cantidad"+string(indice,"#"),cantidad[indice])
next
for indice = 1 to 15
	dw_preliminar.setitem(1,"designacion"+string(indice,"#"),designacion[indice])
next
dw_preliminar.setfocus()
end subroutine

public subroutine f_grabar ();string var_expedidor,var_destinatario,var_observaciones
string var_cantidad,var_designacion,var_pais
string expedidor[1 to 5],destinatario[1 to 5],observaciones[1 to 5]
string cantidad[1 to 9],designacion[1 to 15]
long anyo,factura,indice_array,indice,total


dw_preliminar.accepttext()

anyo    = dec(em_anyo.text)
factura = dec(em_factura.text)

var_expedidor     = ""
var_destinatario  = ""
var_observaciones = ""
var_cantidad      = ""
var_designacion   = ""
var_pais          = dw_preliminar.object.pais_de_origen[1]

for indice = 1 to 5
	expedidor[indice]     = dw_preliminar.getitemstring(1,"expedidor"+string(indice,"#"))
	if isnull(expedidor[indice]) then expedidor[indice] = ""
	destinatario[indice]  = dw_preliminar.getitemstring(1,"destinatario"+string(indice,"#"))
	if isnull(destinatario[indice]) then destinatario[indice] = ""
	observaciones[indice] = dw_preliminar.getitemstring(1,"observaciones"+string(indice,"#"))	
	if isnull(observaciones[indice]) then observaciones[indice] = ""
next
for indice = 1 to 9
	cantidad[indice]      = dw_preliminar.getitemstring(1,"cantidad"+string(indice,"#"))
	if isnull(cantidad[indice]) then cantidad[indice] = ""
next
for indice = 1 to 15
	designacion[indice]   = dw_preliminar.getitemstring(1,"designacion"+string(indice,"#"))
	if isnull(designacion[indice]) then designacion[indice] = ""
next

for indice = 1 to 5
	if expedidor[indice] <> "" then 
		if var_expedidor <> "" then
			var_expedidor = var_expedidor + char(13)+expedidor[indice]
		else
			var_expedidor = expedidor[indice]
		end if
	end if
	if destinatario[indice] <> "" then 
		if var_destinatario <> "" then
			var_destinatario = var_destinatario + char(13)+destinatario[indice]
		else
			var_destinatario = destinatario[indice]
		end if
	end if
	if observaciones[indice] <> "" then 
		if var_observaciones <> "" then
			var_observaciones = var_observaciones + char(13)+observaciones[indice]
		else
			var_observaciones = observaciones[indice]
		end if
	end if
next
for indice = 1 to 9
	if cantidad[indice] <> "" then 
		if var_cantidad <> "" then
			var_cantidad = var_cantidad + char(13)+cantidad[indice]
		else
			var_cantidad = cantidad[indice]
		end if
	end if
next
for indice = 1 to 15
	if designacion[indice] <> "" then 
		if var_designacion <> "" then
			var_designacion = var_designacion + char(13)+designacion[indice]
		else
			var_designacion = designacion[indice]
		end if
	end if	
next

if existe then
	update vencertificado_origen
	set     expedidor = :var_expedidor,
	     destinatario = :var_destinatario,
		 observaciones = :var_observaciones,
		   designacion = :var_designacion,
		      cantidad = :var_cantidad,
		          pais = :var_pais
	where     empresa = :codigo_empresa
	and          anyo = :anyo
	and       factura = :factura;
else
	insert vencertificado_origen
	       (empresa,
			 anyo,
			 factura,
			 expedidor,
			 destinatario,
			 observaciones,
			 designacion,
			 cantidad,
			 pais)
	values (:codigo_empresa,
			 :anyo,
			 :factura,
			 :var_expedidor,
			 :var_destinatario,
			 :var_observaciones,
			 :var_designacion,
			 :var_cantidad,
			 :var_pais);
end if

if sqlca.sqlcode = 0 then
	commit;
else
	rollback;
	messagebox("Atención","Se ha producido un error al grabar")
end if
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Listado Packing List"
This.title=istr_parametros.s_titulo_ventana

dw_preliminar.SetTransObject(SQLCA)
dw_preliminar.sharedata(dw_listado)

em_anyo.text = String(Year(Today()))

f_mascara_columna(dw_preliminar,"venlifac_paldesde",f_mascara_decimales(0))
f_mascara_columna(dw_preliminar,"venlifac_palhasta",f_mascara_decimales(0))

IF istr_parametros.i_nargumentos>1 THEN
	em_anyo.text=istr_parametros.s_argumentos[2]	
	em_factura.text=istr_parametros.s_argumentos[3]	
	IF Not IsNull(em_factura.text) and Trim(em_factura.text) <> "" Then
		em_factura.TriggerEvent("modificado")
		cb_1.triggerevent(clicked!)
	END IF
END IF

em_factura.setfocus()

end event

on ue_listar;//dw_report  = dw_detalle
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//fecha = DateTime(Date(String(sle_fecha.Text)))
//dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end on

on w_lis_certificado_de_origen.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_anyo=create em_anyo
this.em_factura=create em_factura
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_cliente=create st_cliente
this.st_codcli=create st_codcli
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_preliminar=create dw_preliminar
this.dw_listado=create dw_listado
this.dw_bandas=create dw_bandas
this.st_1=create st_1
this.pb_imprimir=create pb_imprimir
this.gb_1=create gb_1
this.pb_borrar=create pb_borrar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.em_factura
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.st_cliente
this.Control[iCurrent+9]=this.st_codcli
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.dw_preliminar
this.Control[iCurrent+13]=this.dw_listado
this.Control[iCurrent+14]=this.dw_bandas
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.pb_imprimir
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.pb_borrar
end on

on w_lis_certificado_de_origen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.em_factura)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_cliente)
destroy(this.st_codcli)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_preliminar)
destroy(this.dw_listado)
destroy(this.dw_bandas)
destroy(this.st_1)
destroy(this.pb_imprimir)
destroy(this.gb_1)
destroy(this.pb_borrar)
end on

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_preliminar)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_preliminar)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_preliminar)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_preliminar)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_lis_certificado_de_origen
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_lis_certificado_de_origen
integer taborder = 30
end type

type st_empresa from w_int_con_empresa`st_empresa within w_lis_certificado_de_origen
integer x = 14
integer y = 4
integer width = 2450
integer height = 96
end type

type pb_1 from upb_salir within w_lis_certificado_de_origen
integer x = 2697
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_lis_certificado_de_origen
integer x = 18
integer y = 88
integer width = 210
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Factura:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_lis_certificado_de_origen
integer x = 37
integer y = 140
integer width = 178
integer height = 76
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type em_factura from u_em_campo within w_lis_certificado_de_origen
integer x = 274
integer y = 140
integer width = 197
integer height = 76
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#######"
string displaydata = "~b"
end type

event modificado;
var_idioma      = f_idioma_venfac(codigo_empresa,Dec(em_anyo.text),Dec(this.text))
var_moneda      = f_divisa_venfac(codigo_empresa,Dec(em_anyo.text),Dec(this.text))
var_codcli      = f_cliente_venfac(codigo_empresa,Dec(em_anyo.text),Dec(this.text))
st_codcli.text  = var_codcli
st_cliente.text = f_razon_o_compuesto_cliente(codigo_empresa,st_codcli.text)
call super::modificado
end event

type st_3 from statictext within w_lis_certificado_de_origen
integer x = 224
integer y = 120
integer width = 46
integer height = 84
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
boolean focusrectangle = false
end type

type cb_2 from u_boton within w_lis_certificado_de_origen
event clicked pbm_bnclicked
integer x = 2103
integer y = 140
integer width = 315
integer height = 76
integer taborder = 60
string text = "&Grabar"
end type

event clicked;f_grabar()
cb_1.triggerevent(clicked!)
end event

type cb_1 from u_boton within w_lis_certificado_de_origen
integer x = 1787
integer y = 140
integer width = 315
integer height = 76
integer taborder = 70
boolean bringtotop = true
string text = "&Consultar"
end type

event clicked;long anyo,factura,existen

if len(em_factura.text)=0 then
	MessageBox("Introduzca la Factura","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_factura)
	Return
End if

em_factura.TriggerEvent("modificado")
dw_preliminar.visible= FALSE
dw_preliminar.reset()
dw_preliminar.SetRedraw(FALSE)

anyo    = dec(em_anyo.text)
factura = dec(em_factura.text)

select count(*)
into   :existen
from   vencertificado_origen
where  empresa = :codigo_empresa
and    anyo    = :anyo
and    factura = :factura;

if isnull(existen) then existen = 0
if existen = 0 then
	existe = false
	f_crear()
else
	existe = true
	f_recuperar()
end if
dw_preliminar.visible= TRUE
dw_preliminar.SetRedraw(TRUE)


end event

type st_cliente from statictext within w_lis_certificado_de_origen
integer x = 727
integer y = 140
integer width = 1029
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_codcli from statictext within w_lis_certificado_de_origen
integer x = 526
integer y = 140
integer width = 201
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_lis_certificado_de_origen
integer x = 2670
integer y = 96
integer width = 146
integer height = 136
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_3 from groupbox within w_lis_certificado_de_origen
integer x = 9
integer y = 88
integer width = 1760
integer height = 144
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type dw_preliminar from datawindow within w_lis_certificado_de_origen
integer y = 228
integer width = 2825
integer height = 1228
boolean bringtotop = true
string dataobject = "dw_certificado_de_origen"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type dw_listado from datawindow within w_lis_certificado_de_origen
boolean visible = false
integer x = 2615
integer y = 120
integer width = 197
integer height = 108
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_certificado_de_origen"
boolean livescroll = true
end type

type dw_bandas from datawindow within w_lis_certificado_de_origen
boolean visible = false
integer x = 434
integer y = 456
integer width = 2107
integer height = 500
integer taborder = 40
string dataobject = "dw_bandas_packig"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type st_1 from statictext within w_lis_certificado_de_origen
integer x = 503
integer y = 88
integer width = 247
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_imprimir from picturebutton within w_lis_certificado_de_origen
integer x = 2688
integer y = 124
integer width = 110
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean originalsize = true
string picturename = "print!"
string disabledname = "c:\bmp\imp32_no.bmp"
alignment htextalign = left!
end type

event clicked;dw_preliminar.accepttext()
f_imprimir_datawindow(dw_listado)
end event

type gb_1 from groupbox within w_lis_certificado_de_origen
integer x = 1774
integer y = 96
integer width = 805
integer height = 136
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_borrar from picturebutton within w_lis_certificado_de_origen
integer x = 2446
integer y = 132
integer width = 110
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "c:\bmp\delete.bmp"
alignment htextalign = left!
end type

event clicked;long anyo,factura

if len(em_anyo.text) = 0 then
	MessageBox("Introduzca el año de la factura","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_anyo)
	Return
End if

if len(em_factura.text)=0 then
	MessageBox("Introduzca la Factura","" ,Exclamation!, OK!, 2)
   f_activar_campo(em_factura)
	Return
End if

anyo    = dec(em_anyo.text)
factura = dec(em_factura.text)

delete vencertificado_origen
where  empresa = :codigo_empresa
and    anyo    = :anyo
and    factura = :factura;

if sqlca.sqlcode = 0	then 
	commit;
else
	rollback;
	messagebox("Atención","Se ha producido un error al borrar")
end if
dw_preliminar.reset()
end event

