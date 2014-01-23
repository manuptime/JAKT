from rapleafApi import RapleafApi
from common.rapleaf import API_KEY

def get_rapleaf_data(hashed_email):
    if not hashed_email:
        return {}
    api = RapleafApi.RapleafApi(API_KEY)
    return api.query_by_md5(hashed_email)
