$PBExportHeader$w_mant_comproveedores.srw
forward
global type w_mant_comproveedores from wc_mantenimientos_tab
end type
type dw_cuentas_contables from u_datawindow within pagina_1
end type
type gb_1 from groupbox within w_mant_comproveedores
end type
type st_2 from statictext within w_mant_comproveedores
end type
type pb_calculadora from u_calculadora within w_mant_comproveedores
end type
type pb_imprimir from picturebutton within w_mant_comproveedores
end type
type st_3 from statictext within w_mant_comproveedores
end type
type dw_listado from datawindow within w_mant_comproveedores
end type
end forward

global type w_mant_comproveedores from wc_mantenimientos_tab
integer width = 3680
integer height = 2336
gb_1 gb_1
st_2 st_2
pb_calculadora pb_calculadora
pb_imprimir pb_imprimir
st_3 st_3
dw_listado dw_listado
end type
global w_mant_comproveedores w_mant_comproveedores

type variables
String var_domi,var_envio,var_correspondencia

string inst_proveedor
end variables

forward prototypes
public function string f_rellena_ceros (integer par_long, string par_cadena)
end prototypes

public function string f_rellena_ceros (integer par_long, string par_cadena);int l,i,k


l = len(par_cadena)
iF l = 5 Then 
	par_cadena = Mid(par_cadena,2,5)
END IF
k = par_long - l


for i = 1 to k
	par_cadena = "0" + par_cadena
	
	
next

return par_cadena



end function

event ue_valores;call super::ue_valores;pag1 = TRUE	
pag2 = TRUE
pag3 = FALSE
pag4 = FALSE
pag5 = FALSE
pag6 = FALSE
pag7 = FALSE
pag8 = FALSE

pag_act3 = FALSE

prin_pag1 = TRUE
prin_pag2 = TRUE
prin_pag3 = FALSE
prin_pag4 = FALSE
prin_pag5 = FALSE
end event

on w_mant_comproveedores.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_2=create st_2
this.pb_calculadora=create pb_calculadora
this.pb_imprimir=create pb_imprimir
this.st_3=create st_3
this.dw_listado=create dw_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.pb_calculadora
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.dw_listado
end on

on w_mant_comproveedores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.pb_calculadora)
destroy(this.pb_imprimir)
destroy(this.st_3)
destroy(this.dw_listado)
end on

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  1
criterio[2]   =  "P"+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion[1]     =  criterio[1]+criterio[2]+criterio[3]
tabla[1]         = "genter"
dw_pag1.Retrieve(codigo_empresa,"P",sle_valor.text)
dw_pag2.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_1.dw_cuentas_contables.Retrieve(codigo_empresa,sle_valor.text,ejercicio_activo)
//dw_pag3.Retrieve(codigo_empresa,sle_valor.text)
CALL Super::ue_recuperar

end event

event ue_inserta_fila;call super::ue_inserta_fila;apartados.pagina_1.dw_pagina1.SetItem(1,"empresa",codigo_empresa)
apartados.pagina_1.dw_pagina1.SetItem(1,"tipoter","P")
apartados.pagina_1.dw_pagina1.SetItem(1,"codigo",sle_valor.text)
apartados.pagina_1.dw_pagina1.SetItem(1,"distribuidor","N")
apartados.pagina_2.dw_pagina2.SetItem(1,"empresa",codigo_empresa)
apartados.pagina_2.dw_pagina2.SetItem(1,"codigo",sle_valor.text)

apartados.pagina_3.dw_pagina3.SetItem(1,"empresa",codigo_empresa)
apartados.pagina_3.dw_pagina3.SetItem(1,"codigo",sle_valor.text)


//	No se ha introducido cuenta. Lo hacemos ahora
//String acreedor,cta
//
//if len(trim(sle_valor.text)) <> 9 then
//	
//	acreedor = dw_pag1.getitemstring(1,"acreedor")
////	if acreedor = "S" then
////		cta = "41000" + f_rellena_ceros(4,sle_valor.text)
////	else	
////		cta = "40000" + f_rellena_ceros(4,sle_valor.text)	
////	end if
//else
//	cta = trim(sle_valor.text)
//end if	
//
//if (left(cta, 2) <> "41") and (left(cta, 2) <> "40") then
//	apartados.pagina_2.dw_pagina2.SetItem(1,"prevision", "S")
//else
//	apartados.pagina_2.dw_pagina2.SetItem(1,"prevision", "N")	
//end if
//
//dw_pag1.setitem(1,"cuenta",cta)
end event

event open;call super::open;titulo= " Mantenimiento de Proveedores"
istr_parametros.s_listado         = "report_mant_comproveedores"
This.title = titulo

apartados.pagina_1.dw_cuentas_contables.SetTransObject(sqlca)

f_mascara_columna(dw_pag2,"dia1",f_mascara_decimales(0))
f_mascara_columna(dw_pag2,"dia2",f_mascara_decimales(0))
f_mascara_columna(dw_pag2,"dia3",f_mascara_decimales(0))

end event

event ue_actualiza_dw;call super::ue_actualiza_dw;// comprueba si esta la cuenta contable en plan de cuentas

string cuenta,variable,nombre_cuenta
Integer var_nivel,bien = 0,registros,i

cuenta        = dw_pag1.Getitemstring(1,"cuenta")
nombre_cuenta = dw_pag1.Getitemstring(1,"razon")
var_nivel     = f_ultimonivel_contaparam(codigo_empresa,ejercicio_activo)

if trim(cuenta)<>"" then

	 SELECT contaplan.titulo INTO :variable FROM contaplan  
   WHERE ( contaplan.ejercicio = :ejercicio_activo ) AND  
         ( contaplan.empresa = :codigo_empresa ) AND  
         ( contaplan.cuenta = :cuenta )   ;
			
   if SQLCA.SQLCode=100 then
		
  	   INSERT INTO contaplan  
                 (ejercicio, 
                  empresa, 
                  cuenta,
                  titulo,
                  analitica,
                  tipocta,
                  directos,   
                  nivel,   
                  coste)
          VALUES (:ejercicio_activo, 
                  :codigo_empresa, 
                  :cuenta,
                  :nombre_cuenta,
                  Null,
                  "4",
                  "s",   
                  :var_nivel,   
                  null);
		End if
End if	



// INSERTAMOS VALORES EN LA TABLA COMPROV
// Comprov contiene algunos datos de comproveedores

int cuantos
dec d1,d2,d3
string obser,form_pago


d1 = apartados.pagina_2.dw_pagina2.getitemnumber(1,"dia1")
d2 = apartados.pagina_2.dw_pagina2.getitemnumber(1,"dia3")
d3 = apartados.pagina_2.dw_pagina2.getitemnumber(1,"dia3")

form_pago = apartados.pagina_2.dw_pagina2.getitemstring(1,"forma_pago")
obser = apartados.pagina_2.dw_pagina2.getitemstring(1,"observaciones")

select count(*) 
into :cuantos
from comprov
where (comprov.empresa	=	:codigo_empresa)
and	(comprov.codigo	=	:sle_valor.text);



if cuantos = 0 then
	// Si no estaba lo insertamos
	insert into comprov
	(empresa,codigo,cod_pago,dia1,dia2,dia3,observaciones)
	values
	(:codigo_empresa,:sle_valor.text,:form_pago,:d1,:d2,:d3,:obser);
	

else
	// Si ya lo estaba lo actualizamos
	update comprov
	set	cod_pago	=	:form_pago,
			dia1		=	:d1,
			dia2		=	:d2,
			dia3		=	:d3,
			observaciones	=	:obser
			where	(comprov.empresa	=	:codigo_empresa)
			and	(comprov.codigo	=	:sle_valor.text);
			
			
end if

// Comprobamos las cuentas contables
if apartados.pagina_1.dw_cuentas_contables.update() = -1 then
	bien = 1
	messagebox("Atención","Error al Actualizar las cuentas contables")
else
	registros = apartados.pagina_1.dw_cuentas_contables.Rowcount()
	
	for i = 1 to registros
		//cuenta        = dw_pag1.Getitemstring(1,"cuenta")
		cuenta        = apartados.pagina_1.dw_cuentas_contables.GetItemString(i,"cuenta")
		nombre_cuenta = dw_pag1.Getitemstring(1,"razon")
		var_nivel     = f_ultimonivel_contaparam(codigo_empresa,ejercicio_activo)
		if trim(cuenta)<>"" then
			SELECT contaplan.titulo INTO :variable FROM contaplan  
			WHERE ( contaplan.ejercicio = :ejercicio_activo ) AND  
					( contaplan.empresa = :codigo_empresa ) AND  
					( contaplan.cuenta = :cuenta )   ;
			if SQLCA.SQLCode=100 then
				
				INSERT INTO contaplan  
							  (ejercicio, 
								empresa, 
								cuenta,
								titulo,
								analitica,
								tipocta,
								directos,   
								nivel,   
								coste)
					 VALUES (:ejercicio_activo, 
								:codigo_empresa, 
								:cuenta,
								:nombre_cuenta,
								"N",
								"4",
								"S",   
								:var_nivel,   
								null);
				if sqlca.sqlcode = -1 then
					bien = 1
					messagebox("Atención","Error al Insertar Cuentas en el Plan Contable")
				end if
			end if
		end if	
	next		
end if
if bien = 1 then
	ROLLBACK;
else
	COMMIT;
end if

end event

event ue_pase_valores;call super::ue_pase_valores;dw_pag2.AcceptText()
//dw_pag2.SetItem(1,"observaciones",dw_pag3.GetItemSTring(1,"observaciones"))
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within w_mant_comproveedores
integer x = 3035
integer y = 184
integer width = 265
integer height = 76
integer taborder = 0
string text = "&Salir"
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within w_mant_comproveedores
integer x = 2766
integer y = 184
integer width = 265
integer height = 76
integer taborder = 0
string text = "&Borrar"
end type

event cb_borrar::clicked;Integer cont, resp
Boolean movim = false
String  cod,cuen
Long    registros,i

// Comprobamos la integridad referencial. Miramos si el proveedor tenía
// pedidos, albaranes o facturas de compras o apuntes contables.
cod = sle_valor.text

select count(*)
  into :cont
  from comcabpedpro
 where comcabpedpro.proveedor = :cod;

if IsNull (cont) then cont = 0

if cont > 0 then
	movim = true
else
  select count(*)
  into :cont
  from comcabalb
  where comcabalb.proveedor = :cod;
	if IsNull (cont) then cont = 0

	if cont > 0 then
		movim = true
	else
		select count(*)
	   into :cont
	   from comcabfac
	   where comcabfac.proveedor = :cod;
		if IsNull (cont) then cont = 0
		if cont > 0 then
			movim = true
		else
			registros = apartados.pagina_1.dw_cuentas_contables.RowCount()
			movim  = false
			for i = 1 to registros
				cuen = apartados.pagina_1.dw_cuentas_contables.GetItemString(i,"cuenta")
				if not(isnull(cuen) or Trim(cuen)="") then
					select count(*)
					into :cont
					from contaapun
					where contaapun.cuenta = :cuen;
					if IsNull (cont) then cont = 0
					if cont > 0 then
						movim = movim or true
					else
						movim = movim or false
					end if
				end if
			next
		end if
	end if
end if

if movim then
	f_mensaje ("Borrado del Proveedor","El proveedor no puede ser dado de baja porque tiene movimientos en alguna empresa. Si quiere inutilizarlo márquelo como inactivo")
else
	resp = Messagebox("Borrado del Proveedor","El proveedor será dado de baja en todas las empresas. ¿ Desea continuar ? ",Question!,YesNo!,2)
	if resp = 2 then return
	// Lo borramos también de todas las empresas
	DELETE FROM genter
	WHERE genter.tipoter = "P"
	  AND genter.codigo = :cod
	  using sqlca;
	  
	DELETE FROM comprov
	WHERE comprov.codigo = :cod
	  using sqlca;
	 
	DELETE FROM comproveedores_cuenta
	WHERE comproveedores_cuenta.codigo = :cod
	  using sqlca;
	  
	DELETE FROM comproveedores
	WHERE comproveedores.codigo = :cod
	  using sqlca;

	DELETE FROM contaplan
	WHERE contaplan.cuenta = :cuen
	  using sqlca;
	  
	if not wc_bloquear() then
		COMMIT using sqlca;
	else
		ROLLBACK using sqlca;
	end if

	sle_valor.text = ""
	Parent.TriggerEvent("ue_desbloquear")
	cb_insertar.Enabled = FALSE
	cb_borrar.Enabled = FALSE
	Parent.TriggerEvent("ue_recuperar")

end if
end event

type cb_insertar from wc_mantenimientos_tab`cb_insertar within w_mant_comproveedores
integer x = 2496
integer y = 184
integer width = 265
integer height = 76
integer taborder = 0
end type

event cb_insertar::clicked;String  variable,nombre_cuenta,cuenta,campo,var_razon,var_tipo
Integer digitos,var_nivel,contador,numero, aviso
str_ventana_alerta parametros
string botones[2]
Long    registros,i,bien
string  var_pais,var_provincia,var_idioma,var_moneda,var_cif,tipopais,var_serie
datawindow dato
Dec{2}  ld_irpf
String  ls_cta_irpf

IF cb_Insertar.enabled=TRUE THEN
	
	if apartados.pagina_1.dw_cuentas_contables.rowcount() < 1 then
		parametros.titulo = "Atención"
		parametros.subtitulo = "Cuenta Contable Proveedor"
		parametros.mensaje = "¿Seguro que desea guardar sin introducir una cta. contable para el proveedor?~nNo se contabilizarán sus facturas."
		botones[1] = "Sí"
		botones[2] = "No"
		parametros.tipo = 2
		parametros.botones = botones
		parametros.mostrar_imagen = true
		openwithparm(wtc_ventana_alerta, parametros)
		aviso = Int(Message.DoubleParm)

		if aviso = 2 then 
			return 
		end if
	end if
	bien = 0
	apartados.pagina_1.dw_pagina1.Accepttext()
	apartados.pagina_2.dw_pagina2.Accepttext()
	
	var_pais      = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'pais')
	var_idioma    = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'idioma')	
	var_moneda    = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'moneda')	
	var_razon     = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'razon')	
	var_cif       = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'cif')	
	
	IF IsNull(var_idioma) or Trim(String(var_idioma))="" THEN
		  campo="idioma"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	END IF
	IF IsNull(var_razon) or Trim(String(var_razon))="" THEN  
		  campo="razon"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	END IF
	IF IsNull(var_moneda) or Trim(String(var_moneda))="" THEN  
		  campo="moneda"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	END IF
	IF IsNull(var_pais) or Trim(String(var_pais))="" THEN
		  campo="pais"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	END IF
	IF IsNull(var_cif) or Trim(String(var_cif))="" THEN  
		tipopais = f_tipo_pais(var_pais)
		Choose case tipopais
			Case "N","C"
			  campo="cif"
			  dato = apartados.pagina_1.dw_pagina1
			  numero = 1	  
		End Choose			 
	END IF	
	
	ld_irpf     = apartados.pagina_2.dw_pagina2.GetItemNumber(1,"irpf")
	ls_cta_irpf = apartados.pagina_2.dw_pagina2.GetItemString(1,"cta_irpf")

	IF Not IsNull(ld_irpf) AND ld_irpf <> 0 THEN
		IF Trim(ls_cta_irpf) = "" THEN
			campo = "cta_irpf"
			dato = apartados.pagina_2.dw_pagina2
			numero = 1
		END IF
	END IF
	
	IF Trim(campo)<>"" THEN
	  	MessageBox(" "+campo+": Campo obligatorio","Introducir el campo ",Exclamation!, OK!,1)
	  	apartados.SelectTab(numero)
	  	dato.setfocus()
	  	dato.SetColumn(campo)
	  	RETURN
	END IF
	
	// control de cuenta contable
	registros = apartados.pagina_1.dw_cuentas_contables.RowCount()
	for i = 1 to registros
		cuenta   = apartados.pagina_1.dw_cuentas_contables.GetItemString(i,"cuenta")
		var_tipo = apartados.pagina_1.dw_cuentas_contables.GetItemString(i,"tipo")
		if isnull(var_tipo) or trim(var_tipo)= "" then
			MessageBox("tipo: Campo obligatorio","Introducir el campo tipo en la cuenta "+cuenta,Exclamation!, OK!,1)
			apartados.SelectTab(1)
			apartados.pagina_1.dw_cuentas_contables.setfocus()
			apartados.pagina_1.dw_cuentas_contables.Setrow(i)
			apartados.pagina_1.dw_cuentas_contables.Scrolltorow(i)
			apartados.pagina_1.dw_cuentas_contables.SetColumn("tipo")
			RETURN
		end if
	next
	
	for i = 1 to registros
		cuenta = apartados.pagina_1.dw_cuentas_contables.GetItemString(i,"cuenta")
	
		IF len(trim(cuenta))<>0 THEN		
			digitos = f_digitos_contaparam(codigo_empresa,ejercicio_activo)
			
			IF len(trim(cuenta))<>digitos THEN
				f_mensaje("Error en cuenta","Número de digitos erroneo.")
				apartados.SelectTab(1)
				RETURN
			END IF		 
			// comprueba si esta la cuenta contable en plan de cuentas
			nombre_cuenta = dw_pag1.Getitemstring(1,"razon")
			var_nivel     = f_ultimonivel_contaparam(codigo_empresa,ejercicio_activo)
			
			IF trim(cuenta)<>"" THEN
				SELECT contaplan.titulo
				INTO :variable
				FROM contaplan  
				WHERE ( contaplan.ejercicio = :ejercicio_activo ) AND  
				( contaplan.empresa = :codigo_empresa ) AND  
				( contaplan.cuenta = :cuenta )   ;
				
				IF SQLCA.SQLCode=100 THEN
					INSERT INTO contaplan  
												(ejercicio, 
												empresa, 
												cuenta,
												titulo,
												analitica,
												tipocta,
												directos,   
												nivel,   
												coste)
					VALUES (:ejercicio_activo, 
								:codigo_empresa, 
								:cuenta,
								:nombre_cuenta,
								"N",
								"4",
								"S",   
								:var_nivel,   
								null);
					if sqlca.sqlcode = -1 then
						bien = 1
						messagebox("Atención","Error al Insertar Cuentas en el Plan Contable")
					end if
				END IF
			END IF
		END IF
	next
	apartados.pagina_2.dw_pagina2.SetItem(apartados.pagina_2.dw_pagina2.GetRow(),"idioma",var_idioma)	
	apartados.pagina_2.dw_pagina2.SetItem(apartados.pagina_2.dw_pagina2.GetRow(),"moneda",var_moneda)	
END IF

CALL Super::Clicked
pag_act2  = TRUE
end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within w_mant_comproveedores
integer taborder = 30
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within w_mant_comproveedores
integer height = 96
end type

type sle_valor from wc_mantenimientos_tab`sle_valor within w_mant_comproveedores
integer x = 302
integer y = 184
integer width = 325
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION PROVEEDORES"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = "" 	



IF istr_parametros.i_nargumentos>1 THEN
	
	  sle_valor.text=istr_parametros.s_argumentos[2]
 	  istr_parametros.i_nargumentos=0
       	  
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
			This.TriggerEvent("modificado")
			Parent.TriggerEvent("ue_recuperar")
     END IF  
  
	  		
END IF


end event

event sle_valor::modificado;call super::modificado;st_2.text = f_razon_genter(codigo_empresa,"P",sle_valor.text)
inst_proveedor = sle_valor.text
end event

type st_1 from wc_mantenimientos_tab`st_1 within w_mant_comproveedores
integer y = 188
integer width = 242
string text = "Código:"
end type

type apartados from wc_mantenimientos_tab`apartados within w_mant_comproveedores
integer x = 32
integer y = 288
integer width = 3570
integer height = 1824
boolean multiline = true
end type

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer width = 3534
integer height = 1696
string text = "General"
dw_cuentas_contables dw_cuentas_contables
end type

on pagina_1.create
this.dw_cuentas_contables=create dw_cuentas_contables
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cuentas_contables
end on

on pagina_1.destroy
call super::destroy
destroy(this.dw_cuentas_contables)
end on

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 23
integer y = 0
integer width = 3515
integer height = 1276
string dataobject = "dw_proveedores1"
end type

event dw_pagina1::clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_pais'
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE 'pb_provincia'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=f_valor_columna(this,This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)
CASE 'pb_codpostal'
   lstr_param.i_nargumentos  = 3
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=f_valor_columna(this,This.GetRow(),"cod_postal")
   OpenWithParm(wi_mant_codpostales,lstr_param)
CASE 'pb_idioma'
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"idioma")
   OpenWithParm(wi_mant_idiomas,lstr_param)  
CASE 'pb_moneda'
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"moneda")
   OpenWithParm(wi_mant_divisas,lstr_param)  
CASE 'pb_contable'
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"cuenta")
   OpenWithParm(w_con_extracto_cuenta,lstr_param)  	
END CHOOSE



//iF f_Objeto_datawindow(This)= "acreedor" Then
//	string acreedor,cta
////	acreedor = dw_pag1.getitemstring(1,"acreedor")
////	if acreedor = "N" then
////		cta = "41000" + f_rellena_ceros(4,sle_valor.text)
////	else	
////		cta = "40000" + f_rellena_ceros(4,sle_valor.text)
////	end if
//	dw_pag1.setitem(1,"cuenta",cta)
//END IF
		
end event

event dw_pagina1::itemfocuschanged;call super::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE this.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'cod_postal')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provincia",var_provincia)
   This.SetItem(This.getrow(),"localidad",var_localidad)   
END IF
END CHOOSE


end event

event dw_pagina1::key;
 bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE	
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "cuenta"
      bus_datawindow = "dw_ayuda_contaplan_proveedores"
		bus_titulo = "VENTANA SELECCION DE CUENTAS"
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"'"
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
		valor_empresa = FALSE
   CASE "cod_postal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
   CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo = "VENTANA SELECCION DE IDIOMAS"
		valor_empresa = FALSE
   CASE "moneda"
      bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE DIVISAS"
		valor_empresa = FALSE
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 IF bus_campo = "provincia" then
   String prefijo,cod_pais,cod_provincia

   prefijo       = GetItemString(This.GetRow(),"prefijo_provincia")
   cod_pais      = GetItemString(This.GetRow(),"pais")
   cod_provincia = GetItemString(This.GetRow(),"provincia")

   if Trim(prefijo)="" or IsNull(prefijo) then
	      SELECT provincias.prefijo
         INTO :prefijo
         FROM provincias  
         WHERE (provincias.pais      = :cod_pais) AND  
               (provincias.provincia = :cod_provincia) USING SQLCA;
         IF SQLCA.SQLCode<>0 THEN
               prefijo=""
         END IF
         This.SetItem(This.getrow(),"prefijo_provincia",prefijo)   
   END IF
  END IF

END IF

end event

event dw_pagina1::rbuttondown; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
		valor_empresa = FALSE
   CASE "cod_postal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
		valor_empresa = FALSE
   CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo = "VENTANA SELECCION DE IDIOMAS"
		valor_empresa = FALSE
   CASE "moneda"
      bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE DIVISAS"
		valor_empresa = FALSE
   CASE "cuenta"
            bus_datawindow = "dw_ayuda_contaplan_proveedores"
		bus_titulo = "VENTANA SELECCION DE CUENTAS"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina1::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(This,"pais")
       f_valores_numericos(This,"provincia")
       f_valores_numericos(This,"idioma")
       f_valores_numericos(This,"moneda")
       //f_valores_numericos(This,"cod_postal")
//---------------------------------------------//
//---------------------------------------------//
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 3534
integer height = 1696
string text = "Dtos. Proveedor"
end type

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 5
integer y = 24
integer width = 3529
integer height = 1684
string dataobject = "dw_comproveedores"
end type

event dw_pagina2::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_pagina2.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_mant_comproveedores"

CHOOSE CASE ls_objeto
			
	CASE 'pb_fpago'
		lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"forma_pago")
		OpenWithParm(wi_mant_carforpag,lstr_param)  
	
	CASE 'pb_fenvio'
		lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"forma_envio")
		OpenWithParm(w_mant_comforenv,lstr_param)  
	
	CASE 'pb_iva'
		lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_iva")
		OpenWithParm(wi_mant_contaiva,lstr_param)  
			
	CASE 'pb_moneda'
		lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"moneda")
		OpenWithParm(wi_mant_divisas,lstr_param)  
	
	CASE 'pb_idioma'
		lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"idioma")
		OpenWithParm(wi_mant_idiomas,lstr_param)  
		
	CASE 'pb_tipo_proveedor'
		lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_proveedor")
		OpenWithParm(w_mant_comtipo_proveedor,lstr_param)  	
		
	CASE 'pb_cta_gastos'
		lstr_param.s_argumentos[2]=string(f_ejercicio_activo(codigo_empresa),"###0")
		lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"cta_gastos")
		OpenWithParm(wi_mant_contaplan,lstr_param)  	
		
	CASE 'pb_banco'
		lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"banco")
		OpenWithParm(wi_mant_carbancos,lstr_param)  			

END CHOOSE


end event

event dw_pagina2::key; bus_filtro = ""
bus_titulo = ""
bus_campo  = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "cta_irpf"
		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS"
	CASE "cta_gastos"
		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS"
	CASE "forma_pago"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "AYUDA SELECCION FORMAS DE PAGO"
	CASE "forma_envio"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_comforenv"
		bus_titulo     = "AYUDA SELECCION FORMAS DE ENVIO"
	CASE "tipo_iva"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_contaiva"
		bus_filtro     = "ejercicio = " + string(integer(ejercicio_activo)) 
		bus_titulo     = "AYUDA SELECCION TIPOS DE IVA"
	CASE "idioma"
		valor_empresa  = FALSE
		bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo     = "AYUDA SELECCION IDIOMAS"
	CASE "moneda"
		valor_empresa  = FALSE
		bus_datawindow = "dw_ayuda_divisas"
		bus_titulo     = "AYUDA SELECCION MONEDA"	
	CASE "banco"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo     = "AYUDA SELECCION DE BANCOS"
	CASE "codigo_cliente"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_clientes"
		bus_titulo     = "AYUDA SELECCION DE CLIENTES"
	CASE "tipo_proveedor"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_comtipo_proveedor"
		bus_titulo     = "AYUDA SELECCION TIPOS DE PROVEEDOR"		
	CASE "empresas_codigo"
		valor_empresa  = false
		bus_datawindow = "dw_ayuda_empresas"
		bus_filtro     = "empresa <> '"+codigo_empresa+"'"
		bus_titulo     = "AYUDA SELECCION DE EMPRESAS"
	CASE "venclientes_codigo_otra_emp"
		valor_empresa  = false
		bus_datawindow = "dw_ayuda_clientes_sin_empresa"
		bus_filtro     = "empresa = '"+this.object.empresas_codigo[this.getrow()]+"'"
		bus_titulo     = "AYUDA SELECCION DE CLIENTES"		
	CASE ELSE
	SetNull(bus_campo)
END CHOOSE

CALL Super::Key

end event

event dw_pagina2::rbuttondown;bus_filtro = ""
bus_titulo = ""
bus_campo  = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "cta_irpf"
		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS"
	CASE "cta_gastos"
		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS"
	CASE "forma_pago"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "AYUDA SELECCION FORMAS DE PAGO"
	CASE "forma_envio"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_comforenv"
		bus_titulo     = "AYUDA SELECCION FORMAS DE ENVIO"
	CASE "tipo_iva"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_contaiva"
		bus_filtro     = "ejercicio = " + string(integer(ejercicio_activo)) 
		bus_titulo     = "AYUDA SELECCION TIPOS DE IVA"
	CASE "idioma"
		valor_empresa  = FALSE
		bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo     = "AYUDA SELECCION IDIOMAS"
	CASE "moneda"
		valor_empresa  = FALSE
		bus_datawindow = "dw_ayuda_divisas"
		bus_titulo     = "AYUDA SELECCION MONEDA"	
	CASE "banco"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo     = "AYUDA SELECCION DE BANCOS"
	CASE "codigo_cliente"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_clientes"
		bus_titulo     = "AYUDA SELECCION DE CLIENTES"
	CASE "tipo_proveedor"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_comtipo_proveedor"
		bus_titulo     = "AYUDA SELECCION TIPOS DE PROVEEDOR"		
	CASE "empresas_codigo" 	
		valor_empresa  = false
		bus_datawindow = "dw_ayuda_empresas"
		bus_filtro     = "empresa <> '"+codigo_empresa+"'"
		bus_titulo     = "AYUDA SELECCION DE EMPRESAS"
	CASE "venclientes_codigo_otra_emp"
		valor_empresa  = false
		bus_datawindow = "dw_ayuda_clientes_sin_empresa"
		bus_filtro     = "empresa = '"+this.object.empresas_codigo[this.getrow()]+"'"
		bus_titulo     = "AYUDA SELECCION DE CLIENTES"				
	CASE ELSE
	SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown


end event

event dw_pagina2::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(this,"forma_pago")
//---------------------------------------------//
//---------------------------------------------//
end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 3534
integer height = 1696
string text = "Observaciones"
end type

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 18
integer y = 20
integer width = 2734
integer height = 884
string dataobject = "dw_comproveedore3"
end type

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
integer width = 3534
integer height = 1696
string text = ""
end type

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer width = 1600
integer height = 880
end type

event dw_pagina4::itemfocuschanged;call super::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE This.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'codpostal')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provincia",var_provincia)
   This.SetItem(This.getrow(),"localidad",var_localidad)   
END IF
END CHOOSE


end event

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 3534
integer height = 1696
string text = ""
end type

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
integer x = 18
integer y = 4
integer width = 178
integer height = 1168
end type

event dw_pagina5::valores_numericos;call super::valores_numericos;f_valores_numericos(This,"cod_pago")
f_valores_numericos(This,"agente1")
f_valores_numericos(This,"agente2")
f_valores_numericos(This,"agente3")
end event

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer width = 3534
integer height = 1696
string text = ""
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
integer width = 242
end type

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer width = 3534
integer height = 1696
string text = ""
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
integer x = 0
integer y = 52
integer width = 270
integer height = 864
end type

event dw_pagina7::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_filtro = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa) ,"#####")
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key


end event

event dw_pagina7::rbuttondown; valor_empresa = TRUE	
bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
 		bus_filtro = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa) ,"#####")
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina7::itemfocuschanged;call super::itemfocuschanged;IF dw_pag7.GetItemSTring(1,"deposito")= "S" Then
	dw_pag7.SetItem(1,"pallets_enteros","S")
ELSE
	dw_pag7.SetItem(1,"pallets_enteros","")
END IF
end event

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 3534
integer height = 1696
string text = ""
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
integer x = 0
integer y = 12
integer width = 521
integer height = 912
end type

type dw_cuentas_contables from u_datawindow within pagina_1
integer x = 1623
integer y = 1284
integer width = 1902
integer height = 404
integer taborder = 31
boolean bringtotop = true
string dataobject = "dw_proveedor_cuenta"
boolean vscrollbar = true
end type

event clicked;call super::clicked;Long donde,variable
String cuenta

if dwo.name = "cb_anyadir" then
	if apartados.pagina_1.dw_pagina1.RowCount() > 0 then
		donde = apartados.pagina_1.dw_cuentas_contables.InsertRow(0)
		apartados.pagina_1.dw_cuentas_contables.SetItem(donde,"empresa",codigo_empresa)
		apartados.pagina_1.dw_cuentas_contables.SetItem(donde,"codigo",sle_valor.text)
		apartados.pagina_1.dw_cuentas_contables.SetItem(donde,"cuenta","")
		apartados.pagina_1.dw_cuentas_contables.SetFocus()
		apartados.pagina_1.dw_cuentas_contables.SetRow(donde)
		apartados.pagina_1.dw_cuentas_contables.ScrollToRow(donde)
		apartados.pagina_1.dw_cuentas_contables.Setcolumn("cuenta")
	end if
end if

if dwo.name = "cb_borrar" then
	if apartados.pagina_1.dw_pagina1.RowCount() > 0 then
		apartados.pagina_1.dw_cuentas_contables.SetFocus()
		donde = apartados.pagina_1.dw_cuentas_contables.GetRow()
		cuenta = apartados.pagina_1.dw_cuentas_contables.GetItemString(donde,"cuenta")
		IF trim(cuenta)<>"" THEN
			SELECT count(*)
			INTO :variable
			FROM contaapun 
			WHERE	( contaapun.empresa = :codigo_empresa ) AND  
					( contaapun.cuenta = :cuenta );
			if isnull(variable) then variable = 0
			if variable = 0 then
				apartados.pagina_1.dw_cuentas_contables.DeleteRow(donde)
			else
				if MessageBox("Atención", "Cuenta utilizada en asientos. ¿Seguro que la quiere borrar?", Exclamation!, YesNo!, 2) = 1 then
					apartados.pagina_1.dw_cuentas_contables.DeleteRow(donde)
				end if
			end if	
		end if
	end if
end if

if not cb_insertar.enabled then
	cb_insertar.enabled = TRUE
end if
end event

event itemchanged;if dwo.name = "cuenta" then
	choose case left(data,3)
		case "523"
			apartados.pagina_1.dw_cuentas_contables.SetItem(row,"tipo","I")
		case "400"
			apartados.pagina_1.dw_cuentas_contables.SetItem(row,"tipo","G")
		case "410"
			apartados.pagina_1.dw_cuentas_contables.SetItem(row,"tipo","A")
		case "440"
			apartados.pagina_1.dw_cuentas_contables.SetItem(row,"tipo","A")
		case else
			apartados.pagina_1.dw_cuentas_contables.SetItem(row,"tipo","")
	end choose
end if
	
end event

event rbuttondown;valor_empresa = TRUE
bus_filtro=""
bus_campo= ""

bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "cuenta"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS "
		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro     = "ejercicio = "+string(f_ejercicio_activo(codigo_empresa))
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event key;valor_empresa = TRUE
bus_filtro=""
bus_campo= ""

bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "cuenta"
		bus_titulo     = "VENTANA SELECCION DE CUENTAS "
		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro     = "ejercicio = "+string(f_ejercicio_activo(codigo_empresa))
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::Key
end event

event ue_valores;call super::ue_valores;ue_marca_linea = TRUE
end event

type gb_1 from groupbox within w_mant_comproveedores
integer x = 2482
integer y = 148
integer width = 832
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_2 from statictext within w_mant_comproveedores
integer x = 741
integer y = 184
integer width = 1710
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type pb_calculadora from u_calculadora within w_mant_comproveedores
event clicked pbm_bnclicked
integer x = 631
integer y = 180
integer taborder = 0
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros

Select count(*) 
Into :registros 
From genter
Where  genter.empresa = :codigo_empresa
And    genter.tipoter = "P";

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   
	STRING TIPO
Select max(convert(int,genter.codigo)+1) 
Into   :sle_valor.text
From   genter
Where  genter.empresa = :codigo_empresa
And    genter.tipoter = "P"
		;
	

//	tipo = inputbox("INDIQUE SI ES PROVEEDOR O ACREEDOR","P (Proveedor) / A (Acreedor) / T (Todos)","P","")
//	tipo = trim(tipo)
//	if tipo <> "P" and tipo <> "A" and tipo <> "T" then
//		messagebox("No se puede continuar","Opción NO válida")
//		return
//	end if
	
//	if tipo = "T" then
//	
//		Select max(convert(int,genter.codigo)+1) 
//		Into   :sle_valor.text
//		From   genter
//		Where  genter.empresa = :codigo_empresa
//		And    genter.tipoter = "P";
//	end if
//	
//	if tipo = "P" then
//	
//		Select max(convert(int,genter.codigo)+1) 
//		Into   :sle_valor.text
//		From   genter
//		Where  genter.empresa = :codigo_empresa
//		And    genter.tipoter = "P"
//		and    genter.codigo  like "40%";
//	end if
//	
//	if tipo = "A" then
//	
//		Select max(convert(int,genter.codigo)+1) 
//		Into   :sle_valor.text
//		From   genter
//		Where  genter.empresa = :codigo_empresa
//		And    genter.tipoter = "P"
//		and    genter.codigo  like "410%";
//	end if
	
	
END IF
Parent.TriggerEvent("ue_recuperar")
end event

type pb_imprimir from picturebutton within w_mant_comproveedores
integer x = 3378
integer y = 180
integer width = 137
integer height = 112
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "print!"
alignment htextalign = left!
end type

event clicked;dw_listado.settransobject(sqlca)
dw_listado.retrieve(codigo_empresa)

f_imprimir_datawindow(dw_listado)
end event

type st_3 from statictext within w_mant_comproveedores
integer x = 3259
integer y = 312
integer width = 334
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Datos Pago"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_mant_comproveedores
boolean visible = false
integer x = 2793
integer y = 4
integer width = 151
integer height = 84
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_comproveedores"
boolean livescroll = true
end type

