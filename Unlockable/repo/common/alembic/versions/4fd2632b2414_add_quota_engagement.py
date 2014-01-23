"""add quota engagements plus count uniques/engagements

Revision ID: 4fd2632b2414
Revises: 2c3abb32729d
Create Date: 2013-10-12 11:36:35.703518

"""

# revision identifiers, used by Alembic.
revision = '4fd2632b2414'
down_revision = '2c3abb32729d'

from alembic import op
import sqlalchemy as sa


def upgrade():
    op.add_column('campaign', sa.Column('quota_engagements', sa.Integer(), server_default="0"))
    op.add_column('commercial', sa.Column('count_uniques', sa.Integer(), server_default="0"))
    op.add_column('commercial', sa.Column('count_engagements', sa.Integer(), server_default="0"))

def downgrade():
    op.drop_column('campaign', 'quota_engagements')
    op.drop_column('commercial', 'count_uniques')
    op.drop_column('commercial', 'count_engagements')
