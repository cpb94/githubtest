$PBExportHeader$w_con_347_nuevo.srw
forward
global type w_con_347_nuevo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_347_nuevo
end type
type pb_2 from upb_imprimir within w_con_347_nuevo
end type
type em_fechadesde from u_em_campo within w_con_347_nuevo
end type
type em_fechahasta from u_em_campo within w_con_347_nuevo
end type
type dw_listado from datawindow within w_con_347_nuevo
end type
type cb_1 from commandbutton within w_con_347_nuevo
end type
type gb_3 from groupbox within w_con_347_nuevo
end type
type gb_2 from groupbox within w_con_347_nuevo
end type
type cb_2 from commandbutton within w_con_347_nuevo
end type
type gb_1 from groupbox within w_con_347_nuevo
end type
type dw_detalle from datawindow within w_con_347_nuevo
end type
type cb_3 from u_boton within w_con_347_nuevo
end type
type dw_lineas from datawindow within w_con_347_nuevo
end type
type gb_10 from groupbox within w_con_347_nuevo
end type
type em_telefono_contacto from u_em_campo within w_con_347_nuevo
end type
type em_persona_contacto from u_em_campo within w_con_347_nuevo
end type
type st_1 from statictext within w_con_347_nuevo
end type
type st_2 from statictext within w_con_347_nuevo
end type
type em_justificante from u_em_campo within w_con_347_nuevo
end type
type ddlb_tipo_declaracion from dropdownlistbox within w_con_347_nuevo
end type
type st_justificante from statictext within w_con_347_nuevo
end type
type dw_cartas from datawindow within w_con_347_nuevo
end type
type pb_cartas from upb_imprimir within w_con_347_nuevo
end type
type st_3 from statictext within w_con_347_nuevo
end type
type st_4 from statictext within w_con_347_nuevo
end type
end forward

shared variables
boolean detalle=true
end variables

global type w_con_347_nuevo from w_int_con_empresa
integer width = 3269
integer height = 2028
string icon = "Application!"
pb_1 pb_1
pb_2 pb_2
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
dw_listado dw_listado
cb_1 cb_1
gb_3 gb_3
gb_2 gb_2
cb_2 cb_2
gb_1 gb_1
dw_detalle dw_detalle
cb_3 cb_3
dw_lineas dw_lineas
gb_10 gb_10
em_telefono_contacto em_telefono_contacto
em_persona_contacto em_persona_contacto
st_1 st_1
st_2 st_2
em_justificante em_justificante
ddlb_tipo_declaracion ddlb_tipo_declaracion
st_justificante st_justificante
dw_cartas dw_cartas
pb_cartas pb_cartas
st_3 st_3
st_4 st_4
end type
global w_con_347_nuevo w_con_347_nuevo

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public function string f_tratar_nif (string arg_nif, string arg_tercero)
public subroutine f_grabar_disco ()
public function string f_relleno_cadena (string cadena, string relleno, string izq_der, integer longitud_cadena)
public function string f_tratar_razon (string arg_razon)
end prototypes

public subroutine f_control (datawindow data);string    libro_iva_ventas_nacional,libro_iva_compras_nacional
string    tipo_cuenta_libro_ventas,tipo_cuenta_libro_compras
string    formula_ventas,formula_compras,sel
string    tercero,tipoter,nif,nombre_tercero,moneda,error_nif
dec       importe_operaciones,irpf
datetime  fecha_desde,fecha_hasta
int       ejercicio
long      indice,total,donde

datastore operaciones

data.reset()
data.SetRedraw(false)

fecha_desde = datetime(date(em_fechadesde.text))
fecha_hasta = datetime(date(em_fechahasta.text))

data.retrieve(codigo_empresa,fecha_desde,fecha_hasta)

ejercicio   = year(date(fecha_desde))

moneda      = f_moneda_empresa(codigo_empresa)

//libro_iva_ventas_nacional  = "1" 
//libro_iva_compras_nacional = "2" 

tipo_cuenta_libro_ventas   = f_tipo_cta_libro(ejercicio,codigo_empresa,libro_iva_ventas_nacional)
tipo_cuenta_libro_compras  = f_tipo_cta_libro(ejercicio,codigo_empresa,libro_iva_compras_nacional)

//IF tipo_cuenta_libro_ventas = "D" then 
//	formula_ventas = " sum(debe - haber) + sum(imponible) "	
// else	
	formula_ventas = " sum(haber - debe) + sum(imponible) "
//End if

//IF tipo_cuenta_libro_compras = "D" then 
	formula_compras = " sum(debe - haber) + sum(imponible) "	
// else	
//	formula_compras = " sum(haber - debe) + sum(imponible) "
//End if

Sel = " SELECT "+formula_ventas+" importe_operaciones,clipro,tipoter " +&
      " FROM   contaapun " +&
      " WHERE  empresa   = '"+codigo_empresa+"'" +&
      " AND    ejercicio = "+string(ejercicio,"####")+&
		" AND    tipoapu  IN (SELECT codigo from contalibros "+&
									"WHERE ejercicio = "+string(ejercicio,"####")+" "+&
									"AND   empresa   = '"+codigo_empresa+"' " +&
									"AND   tipo      = 'V') "+&
		" AND    fapunte between '"+STring(Date(fecha_desde))+"' "+&
		 						 " and '"+STring(Date(fecha_hasta))+"' "+&
		" AND    clipro in ( SELECT codigo from genter "+&
								  "WHERE empresa = '"+codigo_empresa+"' "+&
								  "AND   tipoter = 'C' "+&
								  "AND   pais    = '11' ) "+&		
		" GROUP BY tipoter,clipro "+&
		" UNION "+&
      " SELECT "+formula_compras+" importe_operaciones,clipro,tipoter " +&
      " FROM   contaapun " +&
      " WHERE  empresa   = '"+codigo_empresa+"'" +&
      " AND    ejercicio = "+string(ejercicio,"####")+&
		" AND    tipoapu  IN (SELECT codigo from contalibros "+&
									"WHERE ejercicio = "+string(ejercicio,"####")+" "+&
									"AND   empresa   = '"+codigo_empresa+"' " +&
									"AND   tipo      = 'C') "+&
		" AND    fapunte between '"+STring(Date(fecha_desde))+"' "+&
		 						 " and '"+STring(Date(fecha_hasta))+"' "+&
		" AND    clipro in ( SELECT codigo from genter "+&
								  "WHERE empresa = '"+codigo_empresa+"' "+&
								  "AND   tipoter = 'P' "+&
								  "AND   pais    = '11' ) "+&		
		" GROUP BY tipoter,clipro "

f_mensaje_proceso("Obteniendo datos",0,100)		

//operaciones = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, operaciones)

f_mensaje_proceso("Obteniendo datos",50,100)		

total = operaciones.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Procesando datos",total+indice,total*2)	
	tercero             = operaciones.object.clipro[indice]
	tipoter             = operaciones.object.tipoter[indice]
	importe_operaciones = operaciones.object.importe_operaciones[indice]
	
	if tipoter = "P" then
		irpf = 0
		
		SELECT irpf
		INTO   :irpf
		FROM   comproveedores  
		WHERE  empresa = :codigo_empresa
		AND    codigo  = :tercero;
		
		if isnull(irpf) then irpf = 0		
	else
		irpf = 0
	end if
	
	if importe_operaciones > 3005.06 and irpf = 0 then
		nombre_tercero = f_razon_genter(codigo_empresa,tipoter,tercero)
		nif            = f_cif_genter(codigo_empresa,tipoter,tercero)
		if isnull(nif) then nif = ""
		nif            = f_tratar_nif(nif,nombre_tercero)
		
		if len(nif) <> 9 then
			error_nif = "S"
		else
			error_nif = "N"
		end if
		
		donde = data.insertrow(0)
		
		data.object.empresa[donde]             = codigo_empresa
		data.object.nombre_tercero[donde]      = nombre_tercero
		data.object.tercero[donde]             = tercero
		data.object.tipoter[donde]             = tipoter
		data.object.importe_operaciones[donde] = importe_operaciones
		data.object.nif[donde]                 = nif
		data.object.moneda[donde]              = moneda
		data.object.error_nif[donde]           = error_nif
	end if
next

destroy operaciones

data.Sort()
data.GroupCalc()
data.SetRedraw(TRUE)

end subroutine

public function string f_tratar_nif (string arg_nif, string arg_tercero);string var_nif,nuevo_nif,caracter
long   indice,total,asci,longitud_nif

var_nif = Upper(trim(arg_nif))
nuevo_nif = ""
total = len(var_nif)
for indice = 1 to total
	caracter = mid(var_nif,indice,1)
	asci     = asc(caracter)
	if (asci >= 48 and asci <= 90) then
		nuevo_nif = nuevo_nif + caracter
	end if
next

longitud_nif = 9
		
if len(nuevo_nif) <> longitud_nif then	
	messagebox("Error en NIF ","El NIf "+nuevo_nif+" de "+arg_tercero+" no tiene la longitud esperada.")
end if

return nuevo_nif
end function

public subroutine f_grabar_disco ();string  tipo_registro,modelo_declaracion,ejercicio,nif_declarante,razon_empresa,tipo_soporte
string  telefono_contacto,persona_contacto,numero_justificante,tipo_declaracion,justificante_anterior
string  numero_personas_entidades,importe_total_operaciones,numero_inmuebles,importe_total_inmuebles
string  blancos,sello_electronico,registro_declarante,lineas_defectuosas
string  nif_declarado,nif_representante,razon_declarado,tipo_hoja,codigo_provincia,codigo_pais
string  clave_codigo,importe_operaciones,operacion_seguro,arrendamiento_local,registro_declarado
string  fichero,ejer_corto,moneda_empresa
long    indice,total,donde,v_ejercicio,res,factor_conversion
dec     importe_total
int     decimales_moneda_empresa
boolean bien = true

moneda_empresa           = f_moneda_empresa(codigo_empresa)
decimales_moneda_empresa = f_decimales_moneda(moneda_empresa)

factor_conversion = 1

for indice = 1 to decimales_moneda_empresa
	factor_conversion = factor_conversion * 10
next

dw_lineas.reset()
v_ejercicio = year(date(em_fechadesde.text))
total       = dw_detalle.rowcount()

//TIPO DE REGISTRO 1 : REGISTRO DECLARANTE

tipo_registro       = "1"
modelo_declaracion  = "347"
ejercicio           = string(v_ejercicio,"####")
nif_declarante      = f_tratar_nif(f_cif_empresa(codigo_empresa),f_nombre_empresa(codigo_empresa))
razon_empresa       = f_tratar_razon(f_nombre_empresa(codigo_empresa))
razon_empresa       = f_relleno_cadena(razon_empresa," ","D",40)
tipo_soporte        = "D"
telefono_contacto   = em_telefono_contacto.text
persona_contacto    = em_persona_contacto.text
persona_contacto    = f_relleno_cadena(persona_contacto," ","D",40)
numero_justificante = f_relleno_cadena("","0","I",13)

choose case ddlb_tipo_declaracion.text
	case "Normal"
		tipo_declaracion      = "  "
		justificante_anterior = f_relleno_cadena("","0","I",13)
	case "Complementaria"
		tipo_declaracion      = "C "
		justificante_anterior = f_relleno_cadena("","0","I",13)
	case "Sustitutiva"
		tipo_declaracion      = " S"
		justificante_anterior = f_relleno_cadena(em_justificante.text,"0","I",13)
end choose

numero_personas_entidades = string(total,"########")
numero_personas_entidades = f_relleno_cadena(numero_personas_entidades,"0","I",9)

for indice = 1 to total
	importe_total = importe_total + dw_detalle.object.importe_operaciones[indice]
next
importe_total_operaciones = string(importe_total * factor_conversion,"##############")
importe_total_operaciones = f_relleno_cadena(importe_total_operaciones,"0","I",15)

numero_inmuebles          = f_relleno_cadena("","0","I",9)
importe_total_inmuebles   = f_relleno_cadena("","0","I",15)
blancos                   = f_relleno_cadena(""," ","D",54)
sello_electronico         = f_relleno_cadena(""," ","D",13)

registro_declarante = tipo_registro             +&
							 modelo_declaracion        +&
							 ejercicio                 +&
							 nif_declarante            +&
							 razon_empresa             +&
							 tipo_soporte              +&
							 telefono_contacto         +&
							 persona_contacto          +&
							 numero_justificante       +&
							 tipo_declaracion          +&
							 justificante_anterior     +&
							 numero_personas_entidades +&
							 importe_total_operaciones +&
							 numero_inmuebles          +&
							 importe_total_inmuebles   +&
							 blancos                   +&
							 sello_electronico

donde = dw_lineas.insertrow(0)							

dw_lineas.object.linea[donde] = registro_declarante

if len(registro_declarante) <> 250 then
	bien = false
	lineas_defectuosas = string(donde,"####")+"("+string(len(registro_declarante),"###")+")"
end if

for indice = 1 to total
	f_mensaje_proceso("Procesando :",indice,total)
	// TIPO DE REGISTRO 2 : REGISTRO DE DECLARADO
	
	tipo_registro       = "2"
	modelo_declaracion  = "347"
	ejercicio           = string(v_ejercicio,"####")	
	nif_declarado       = dw_detalle.object.nif[indice]
	nif_representante   = f_relleno_cadena(""," ","D",9)
	razon_declarado     = f_tratar_razon(dw_detalle.object.nombre_tercero[indice])
	razon_declarado     = f_relleno_cadena(razon_declarado," ","D",40)
	tipo_hoja           = "D"
	codigo_provincia    = trim(f_provincia_genter(codigo_empresa,dw_detalle.object.tipoter[indice],dw_detalle.object.tercero[indice]))
	codigo_provincia    = f_relleno_cadena(codigo_provincia,"0","I",2)
	codigo_pais         = trim(f_pais_genter(codigo_empresa,dw_detalle.object.tipoter[indice],dw_detalle.object.tercero[indice]))
	if codigo_pais = "11" then
		codigo_pais = ""
	end if
	codigo_pais         = f_relleno_cadena(codigo_pais,"0","I",3)
	
	if dw_detalle.object.tipoter[indice] = "C" then
		clave_codigo = "B" //Entregas
	else
		clave_codigo = "A" //Adquisiciones
	end if
	
	importe_operaciones = string(dw_detalle.object.importe_operaciones[indice] * factor_conversion,"###############")
	importe_operaciones = f_relleno_cadena(importe_operaciones,"0","I",15)
	
	operacion_seguro    = " "
	arrendamiento_local = " "
	blancos             = f_relleno_cadena(""," ","D",151)
	
	registro_declarado = tipo_registro       +&
								modelo_declaracion  +&
								ejercicio           +&
								nif_declarante      +&
								nif_declarado       +&
								nif_representante   +&
								razon_declarado     +&
								tipo_hoja           +&
								codigo_provincia    +&
								codigo_pais         +&
								clave_codigo        +&
								importe_operaciones +&
								operacion_seguro    +&
								arrendamiento_local +&
								blancos								
	
	donde = dw_lineas.insertrow(0)							
	
	dw_lineas.object.linea[donde] = registro_declarado
	
	if len(registro_declarado) <> 250 then
		bien = false
		lineas_defectuosas = lineas_defectuosas + " " + string(donde,"####")+"("+string(len(registro_declarado),"###")+")"
	end if	
next

if not(bien) then
	if messagebox("Atención","Se han detectado errores el las lineas : "+lineas_defectuosas+"~n¿Desea grabar el fichero de todas formas?",StopSign!,YesNo!,1) = 1 then
		bien = true
	end if
end if
if bien then
	ejer_corto = mid(ejercicio,3,2)
	fichero    = "OP347" + ejer_corto+ ".TXT"
	
	if dw_lineas.rowcount() > 0 then
		res = dw_lineas.saveas("a:\" + fichero,text!,false)
		if res = -1 then messagebox("ERROR","Al grabar al disquete")
		if res = 1 then messagebox("CORRECTO","Grabado correctamente, nombre del archivo : " + fichero )
	end if		
else
	messagebox("Error","Operación cancelada")
end if
end subroutine

public function string f_relleno_cadena (string cadena, string relleno, string izq_der, integer longitud_cadena);int l,i,k

cadena = upper(cadena)
cadena = trim(cadena)
l = len(cadena)
k = longitud_cadena - l

if l >= longitud_cadena then
	cadena = left(cadena,longitud_cadena)
else
	for i = 1 to k
		if izq_der = "I" then
			cadena = relleno + cadena
		else
			cadena = cadena + relleno
		end if
	next
end if

return cadena

end function

public function string f_tratar_razon (string arg_razon);string var_razon,nueva_razon,caracter,caracter_ant
long   indice,total,asci

var_razon    = Upper(trim(arg_razon))
nueva_razon  = ""
total        = len(var_razon)
caracter_ant = ''

for indice = 1 to total
	caracter = mid(var_razon,indice,1)
	
	choose case caracter
		case "Á"
			caracter = "A"
		case "É"
			caracter = "E"
		case "Í"
			caracter = "I"
		case "Ó"
			caracter = "O"
		case "Ú"
			caracter = "U"
		case "Ñ"
			caracter = char(209)
		case "Ç"
			caracter = char(199)
		case "(",")"
			caracter = ""		
		case " "
			if caracter_ant = ' ' then
				caracter = ""					
			end if
	end choose	
	nueva_razon  = nueva_razon + caracter
	caracter_ant = caracter
next

return nueva_razon
end function

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event ue_pagina_arriba;f_pagina_arriba(dw_detalle)
end event

event ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event ue_pagina_abajo;f_pagina_abajo(dw_detalle)
end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Consulta 347"
This.title=istr_parametros.s_titulo_ventana

em_fechadesde.text = String(Today())
em_fechahasta.text = String(Today())

dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_cartas.SetTransObject(SQLCA)

f_activar_campo(em_fechadesde)



end event

on w_con_347_nuevo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.cb_2=create cb_2
this.gb_1=create gb_1
this.dw_detalle=create dw_detalle
this.cb_3=create cb_3
this.dw_lineas=create dw_lineas
this.gb_10=create gb_10
this.em_telefono_contacto=create em_telefono_contacto
this.em_persona_contacto=create em_persona_contacto
this.st_1=create st_1
this.st_2=create st_2
this.em_justificante=create em_justificante
this.ddlb_tipo_declaracion=create ddlb_tipo_declaracion
this.st_justificante=create st_justificante
this.dw_cartas=create dw_cartas
this.pb_cartas=create pb_cartas
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.dw_detalle
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.dw_lineas
this.Control[iCurrent+14]=this.gb_10
this.Control[iCurrent+15]=this.em_telefono_contacto
this.Control[iCurrent+16]=this.em_persona_contacto
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.em_justificante
this.Control[iCurrent+20]=this.ddlb_tipo_declaracion
this.Control[iCurrent+21]=this.st_justificante
this.Control[iCurrent+22]=this.dw_cartas
this.Control[iCurrent+23]=this.pb_cartas
this.Control[iCurrent+24]=this.st_3
this.Control[iCurrent+25]=this.st_4
end on

on w_con_347_nuevo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.dw_detalle)
destroy(this.cb_3)
destroy(this.dw_lineas)
destroy(this.gb_10)
destroy(this.em_telefono_contacto)
destroy(this.em_persona_contacto)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_justificante)
destroy(this.ddlb_tipo_declaracion)
destroy(this.st_justificante)
destroy(this.dw_cartas)
destroy(this.pb_cartas)
destroy(this.st_3)
destroy(this.st_4)
end on

event ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_347_nuevo
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_347_nuevo
integer x = 110
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_347_nuevo
integer x = 14
integer width = 3035
end type

type pb_1 from upb_salir within w_con_347_nuevo
integer x = 3077
integer y = 4
integer width = 119
integer height = 100
integer taborder = 0
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_347_nuevo
integer x = 3072
integer y = 292
integer height = 92
integer taborder = 0
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
boolean originalsize = false
string picturename = "print!"
end type

event clicked;f_control(dw_listado)

f_imprimir_datawindow(dw_listado)


end event

type em_fechadesde from u_em_campo within w_con_347_nuevo
integer x = 32
integer y = 168
integer width = 256
integer height = 88
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_347_nuevo
integer x = 306
integer y = 168
integer width = 256
integer height = 88
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_listado from datawindow within w_con_347_nuevo
boolean visible = false
integer x = 2510
integer y = 116
integer width = 73
integer height = 52
string dataobject = "report_con_347_nuevo"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_con_347_nuevo
integer x = 2167
integer y = 188
integer width = 270
integer height = 72
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Ok"
end type

event clicked;f_control(dw_detalle)

end event

type gb_3 from groupbox within w_con_347_nuevo
integer x = 2149
integer y = 148
integer width = 581
integer height = 124
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_347_nuevo
integer x = 585
integer y = 112
integer width = 1559
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de declaración"
end type

type cb_2 from commandbutton within w_con_347_nuevo
integer x = 2441
integer y = 188
integer width = 270
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Resumen"
end type

event clicked;if detalle then
	dw_detalle.modify("datawindow.detail.height=0")
	dw_detalle.modify("datawindow.trailer.2.height=0")
	dw_listado.modify("datawindow.detail.height=0")
	dw_listado.modify("datawindow.trailer.2.height=0")
	cb_2.text="Detalle"
else
	dw_detalle.modify("datawindow.detail.height=77")
	dw_detalle.modify("datawindow.trailer.2.height=77")
	dw_listado.modify("datawindow.detail.height=77")
	dw_listado.modify("datawindow.trailer.2.height=77")
	cb_2.text="Resumen"
end if

detalle=not detalle
end event

type gb_1 from groupbox within w_con_347_nuevo
integer x = 18
integer y = 112
integer width = 562
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type dw_detalle from datawindow within w_con_347_nuevo
integer y = 436
integer width = 3182
integer height = 1396
string dataobject = "dw_con_347_nuevo"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//this.Object.elgrafico.visible = 0
//grafico = "N"
end event

event clicked;//IF f_objeto_datawindow(This)= "grafico" Then
//	IF grafico = "N" Then
//		grafico = "S"
//		this.Object.elgrafico.x = 0
//		this.Object.elgrafico.y = 0
//		this.Object.elgrafico.height = 1100
//		this.Object.elgrafico.width = 3031
//		this.Object.elgrafico.visible = 1
//	ELSE
//		grafico = "N"
//		this.Object.elgrafico.visible = 0
//	END IF
//
//END IF
end event

type cb_3 from u_boton within w_con_347_nuevo
integer x = 2400
integer y = 308
integer width = 430
integer height = 100
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;
if messagebox("ATENCIÓN","La información se va a grabar en disquete~n¿Desea continuar?",question!,yesno!,1) = 1 then
	if len(em_telefono_contacto.text) = 9 then
		if len(em_persona_contacto.text) > 0 then
			f_grabar_disco()
		else
			messagebox("Atención","Debe rellenar el campo persona de contacto")	
			em_persona_contacto.setfocus()
		end if
	else
		messagebox("Atención","Debe rellenar el campo telefono de contacto")	
		em_telefono_contacto.setfocus()		
	end if
end if

end event

type dw_lineas from datawindow within w_con_347_nuevo
boolean visible = false
integer x = 1435
integer y = 124
integer width = 626
integer height = 124
integer taborder = 120
boolean bringtotop = true
string dataobject = "dw_347_nuevo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_10 from groupbox within w_con_347_nuevo
integer x = 18
integer y = 264
integer width = 2830
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Soporte Magnetico"
end type

type em_telefono_contacto from u_em_campo within w_con_347_nuevo
integer x = 530
integer y = 320
integer width = 306
integer height = 88
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
maskdatatype maskdatatype = numericmask!
string mask = "#########"
end type

type em_persona_contacto from u_em_campo within w_con_347_nuevo
integer x = 1330
integer y = 320
integer width = 1056
integer height = 88
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 16777215
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

type st_1 from statictext within w_con_347_nuevo
integer x = 46
integer y = 328
integer width = 485
integer height = 60
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
string text = "Telefono Contacto:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_347_nuevo
integer x = 846
integer y = 328
integer width = 485
integer height = 60
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
string text = "Persona Contacto:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_justificante from u_em_campo within w_con_347_nuevo
boolean visible = false
integer x = 1714
integer y = 168
integer width = 411
integer height = 88
integer taborder = 100
boolean bringtotop = true
long backcolor = 16777215
maskdatatype maskdatatype = numericmask!
string mask = "#############"
end type

type ddlb_tipo_declaracion from dropdownlistbox within w_con_347_nuevo
integer x = 608
integer y = 168
integer width = 421
integer height = 344
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Normal"
boolean vscrollbar = true
string item[] = {"Normal","Complementaria","Sustitutiva"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if this.text = "Sustitutiva" then
	st_justificante.visible = true
	em_justificante.visible = true
else
	st_justificante.visible = false
	em_justificante.visible = false
end if
end event

type st_justificante from statictext within w_con_347_nuevo
boolean visible = false
integer x = 1047
integer y = 184
integer width = 667
integer height = 76
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
string text = "Nº Justificante Declaración"
boolean focusrectangle = false
end type

type dw_cartas from datawindow within w_con_347_nuevo
boolean visible = false
integer x = 2793
integer y = 132
integer width = 101
integer height = 52
integer taborder = 30
string dataobject = "report_cartas_347_nuevo"
boolean livescroll = true
end type

type pb_cartas from upb_imprimir within w_con_347_nuevo
integer x = 3077
integer y = 188
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
boolean originalsize = false
string picturename = "print!"
end type

event clicked;f_control(dw_cartas)

f_imprimir_datawindow(dw_cartas)


end event

type st_3 from statictext within w_con_347_nuevo
integer x = 2907
integer y = 196
integer width = 169
integer height = 64
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
string text = "Cartas"
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_347_nuevo
integer x = 2866
integer y = 300
integer width = 206
integer height = 64
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
string text = "Listado"
boolean focusrectangle = false
end type

